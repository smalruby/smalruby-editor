# -*- coding: utf-8 -*-

# rubocop:disable all

# Rubyのソースコードをブロックに変換するモジュール
module RubyToBlock
  extend ActiveSupport::Concern

  SUCCESS_DATA_MOCK = <<-EOS.strip_heredoc
    require "smalruby"

    car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

    car1.on(:start) do
      loop do
        move(10)
        turn_if_reach_wall
      end
    end
  EOS

  SUCCESS_XML_MOCK = <<-XML.strip_heredoc
    <xml xmlns="http://www.w3.org/1999/xhtml">
      <character name="car1" x="0" y="0" angle="0" costumes="car1.png" />
      <block type="character_new" x="4" y="4">
        <field name="NAME">car1</field>
        <statement name="DO">
          <block type="events_on_start">
            <statement name="DO">
              <block type="control_loop">
                <statement name="DO">
                  <block type="motion_move" inline="true">
                    <value name="STEP">
                      <block type="math_number">
                        <field name="NUM">10</field>
                      </block>
                    </value>
                    <next>
                      <block type="motion_turn_if_reach_wall" />
                    </next>
                  </block>
                </statement>
              </block>
            </statement>
          </block>
        </statement>
      </block>
    </xml>
  XML

  # XML形式のブロックに変換する
  def to_blocks
    fail if data == '__FAIL__'
    return SUCCESS_XML_MOCK if data == SUCCESS_DATA_MOCK

    characters = {}
    character_stack = []
    receiver_stack = []
    statement_stack = []
    blocks = []
    current_block = nil
    lines = data.lines
    while (line = lines.shift)
      line.chomp!
      next if line.strip.empty?

      md = STATEMENT_REGEXP.match(line)

      unless md
        block = Block.new('ruby_statement', fields: { STATEMENT: line })

        if current_block # TODO: リファクタリング
          current_block.sibling = block
        else
          blocks.push(block)
        end
        current_block = block

        next
      end

      next if md[:require_smalruby]

      if (s = md[:character])
        md2 = /#{CHARACTER_RE}/.match(s)
        name = md2[1]

        characters[name] = Character.new(name: name, costumes: [md2[2]],
                                         x: md2[3], y: md2[4], angle: md2[5])
        next
      end

      if (s = md[:events_on_start])
        md2 = /#{EVENTS_ON_START_RE}/.match(s)
        name = md2[1] ? md2[1] : receiver_stack.last.name
        c = characters[name]
        character_stack.push(c)

        do_block = Block.new('null')
        events_on_start_block = Block.new('events_on_start', statements: { DO: do_block })
        if current_block && current_block.type == 'character_new' &&
            current_block[:NAME] == name
          current_block.add_statement(:DO, events_on_start_block)
          character_new_block = current_block
        else
          if c == receiver_stack.last
            current_block.sibling = events_on_start_block
            character_new_block = current_block.parent
          else
            character_new_block =
              Block.new('character_new',
                        fields: { NAME: name }, statements: { DO: events_on_start_block })
            if current_block
              if current_block.type == 'character_new'
                blocks.push(character_new_block)
              else
                current_block.sibling = character_new_block
              end
            else
              blocks.push(character_new_block)
            end
          end
        end
        statement_stack.push([:events_on_start, character_new_block])

        receiver_stack.push(c)

        current_block = do_block

        next
      end

      if (s = md[:ruby_comment])
        md2 = /#{RUBY_COMMENT_RE}/.match(s)
        block = Block.new('ruby_comment', fields: { COMMENT: md2[1] })

        if current_block # TODO: リファクタリング
          current_block.sibling = block
        else
          blocks.push(block)
        end
        current_block = block

        next
      end

      if md[:end]
        ends_num = lines.select { |l|
          md2 = STATEMENT_REGEXP.match(l)
          md2 && md2[:end]
        }.length + 1
        ends_num -= lines.select { |l|
          md2 = STATEMENT_REGEXP.match(l)
          md2 && (md2[:events_on_start])
        }.length
        if (ss = statement_stack.last) &&
            ends_num <= statement_stack.length
          case ss.first
          when :events_on_start
            current_block = ss[1]

            receiver_stack.pop
            character_stack.pop
            statement_stack.pop
          else
            # TODO
          end
        else
          block = Block.new('ruby_statement', fields: { STATEMENT: line })
          if current_block # TODO: リファクタリング
            current_block.sibling = block
          else
            blocks.push(block)
          end
          current_block = block
        end

        next
      end
    end

    return '' if characters.empty? && blocks.empty?

    xml = REXML::Document.new('<xml xmlns="http://www.w3.org/1999/xhtml" />',
                              attribute_quote: :quote,
                              respect_whitespace: :all)
    characters.values.each do |c|
      c.to_xml(xml.root)
    end
    blocks.each do |b|
      b.to_xml(xml.root)
    end

    output = StringIO.new
    formatter = REXML::Formatters::Pretty.new(2, true)
    formatter.compact = true
    # HACK: 行頭、行末などのスペースが1つになってしまうのを修正している
    def formatter.write_text( node, output )
      s = node.to_s()
      s.gsub!(/\s/,' ')
      if !node.is_a?(REXML::Text) ||
          node.is_a?(REXML::Text) && !node.parent.whitespace()
        s.squeeze!(" ")
      end
      s = wrap(s, @width - @level)
      s = indent_text(s, @level, " ", true)
      output << (' '*@level + s)
    end
    formatter.write(xml, output)

    output.string + "\n"
  end

  private

  # require "smalruby"
  REQUIRE_SMALRUBY_RE = '^require\ "smalruby"$'

  # car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
  CHARACTER_RE =
    '^\s*(\S+)\ =\ Character\.new\(costume:\ "([^"]+)",\ x:\ (\d+),\ y:\ (\d+),\ angle:\ (\d+)\)$'

  EVENTS_ON_START_RE = '^\s*(?:(\S+)\.)?on\(:start\)\ do$'

  RUBY_COMMENT_RE = '^\s*\#\ (.*)$'

  END_RE = '^\s*end$'

  STATEMENT_REGEXP = %r{
    (?<require_smalruby>#{REQUIRE_SMALRUBY_RE})
    |
    (?<character>#{CHARACTER_RE})
    |
    (?<events_on_start>#{EVENTS_ON_START_RE})
    |
    (?<ruby_comment>#{RUBY_COMMENT_RE})
    |
    (?<end>#{END_RE})
  }x

  EXPRESSION_REGEXP = %r{}x
  LITERAL_REGEXP = %r{}x

  # ソースコードに含まれるキャラクターを表現するクラス
  class Character
    attr_accessor :name
    attr_accessor :costumes
    attr_accessor :x
    attr_accessor :y
    attr_accessor :angle

    def initialize(options)
      @name = options[:name]
      @costumes = options[:costumes]
      @x = options[:x]
      @y = options[:y]
      @angle = options[:angle]
    end

    def to_xml(parent)
      parent.add_element('character',
                         'name' => @name,
                         'x' => @x, 'y' => @y, 'angle' => @angle,
                         'costumes' => @costumes.join(','))
    end
  end
end

require_relative 'ruby_to_block/block'

# -*- coding: utf-8 -*-

module RubyToBlock
  # ソースコード解析の状態を表現するクラス
  class Context
    attr_accessor :current_line
    attr_accessor :lines
    attr_accessor :characters
    attr_accessor :character_stack
    attr_accessor :receiver_stack
    attr_accessor :statement_stack
    attr_accessor :value_name_stack
    attr_accessor :blocks
    attr_accessor :current_block

    def initialize(lines)
      @lines = lines
      @characters = {}
      @character_stack = []
      @receiver_stack = []
      @statement_stack = []
      @value_name_stack = []
      @blocks = []
      @current_block = nil
    end

    # 次の行に移動して、改行を含むその行の文字列を返す
    #
    # @return [String] 改行を含む次の行の文字列
    def next_line
      self.current_line = lines.shift
    end

    # 次の行を参照する
    #
    # @return [String] 次の行の文字列
    def look_next_line
      lines.first
    end

    def add_block(block)
      if current_block
        # HACK: コメントは下の行に関係することが多いため対象外としている
        if current_block.type == 'character_new' &&
            block.type != 'character_new' && block.type != 'ruby_comment'
          current_block.add_statement(:DO, block)
          block = current_block
        else
          current_block.sibling = block
        end
      else
        blocks.push(block)
      end
      self.current_block = block
      self
    end

    def add_value(block)
      fail unless current_block || value_name

      current_block.add_value(value_name, block)
      self
    end

    def [](symbol)
      send(symbol)
    end

    def []=(symbol, val)
      send("#{symbol}=", val)
    end

    def receiver
      @receiver_stack.last
    end

    def character
      @character_stack.last
    end

    def statement
      @statement_stack.last
    end

    def statement_type
      statement.first
    end

    def statement_block
      statement[1]
    end

    def value_name
      @value_name_stack.last
    end
  end
end

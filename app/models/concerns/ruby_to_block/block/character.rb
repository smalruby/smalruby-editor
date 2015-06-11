# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    # ソースコードに含まれるキャラクターを表現するクラス
    class Character < Base
      # rubocop:disable LineLength
      blocknize ['^\s*',
                 '(\S+)', '\s*=\s*', 'Character\.new\(',
                 'costume:\s*("[^"]+"|\[\s*"[^"]+"\s*(?:,\s*"[^"]+".*)*\])\s*',
                 '(?:,\s*costume_index:\s*(\d+)\s*)?',
                 ',\s*x:\s*(\d+)\s*',
                 ',\s*y:\s*(\d+)\s*',
                 ',\s*angle:\s*(\d+)\s*',
                 '(?:,\s*rotation_style:\s+:(free|left_right|none)\s*)?',
                 '\)',
                 '\s*$'].join(""),
                statement: true
      # rubocop:enable LineLength

      attr_accessor :name
      attr_accessor :costumes
      attr_accessor :costume_index
      attr_accessor :x
      attr_accessor :y
      attr_accessor :angle
      attr_accessor :rotation_style

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        name = md2[1]
        costumes = md2[2].scan(/"([^"]+)"/).flatten
        context[:characters][name] = new(name: name,
                                         costumes: costumes,
                                         costume_index: md2[3] || "0",
                                         x: md2[4],
                                         y: md2[5],
                                         angle: md2[6],
                                         rotation_style: md2[7] || "free")

        true
      end

      def initialize(options)
        @name = options[:name]
        @costumes = options[:costumes]
        @costume_index = options[:costume_index]
        @x = options[:x]
        @y = options[:y]
        @angle = options[:angle]
        @rotation_style = options[:rotation_style]
      end

      def to_xml(parent)
        attrs = {
          "name" => @name,
          "x" => @x,
          "y" => @y,
          "angle" => @angle,
          "costumes" => @costumes.join(","),
        }
        if @costume_index != "0"
          attrs["costume_index"] = @costume_index
        end
        if @rotation_style != "free"
          attrs["rotation_style"] = @rotation_style
        end
        parent.add_element("character", attrs)
      end
    end
  end
end

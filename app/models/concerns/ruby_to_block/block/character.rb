# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    # ソースコードに含まれるキャラクターを表現するクラス
    class Character < Base
      # rubocop:disable LineLength
      blocknize '^\s*(\S+)\s*=\s*Character\.new\(costume:\s*"(\s*[^"]+\s*)"\s*,\s*x:\s*(\s*\d+\s*)\s*,\s*y:\s*(\s*\d+\s*)\s*,\s*angle:\s*(\s*\d+\s*)\)\s*$',
                statement: true
      # rubocop:enable LineLength

      attr_accessor :name
      attr_accessor :costumes
      attr_accessor :x
      attr_accessor :y
      attr_accessor :angle

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        name = md2[1]
        context[:characters][name] = new(name: name, costumes: [md2[2]],
                                         x: md2[3], y: md2[4], angle: md2[5])

        true
      end

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
end

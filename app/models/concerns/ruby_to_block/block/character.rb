# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    # ソースコードに含まれるキャラクターを表現するクラス
    class Character < Base
      # rubocop:disable LineLength
      blocknize '^\s*(\S+)\s*=\s*Character\.new\(costume:\s*"(\s*[^"]+\s*)"\s*,\s*x:\s*(\s*\d+\s*)\s*,\s*y:\s*(\s*\d+\s*)\s*,\s*angle:\s*(\s*\d+\s*)(?:,\s*rotation_style:\s*\s*:(free|left_right|none)\s*)?\)\s*$',
                statement: true
      # rubocop:enable LineLength

      attr_accessor :name
      attr_accessor :costumes
      attr_accessor :x
      attr_accessor :y
      attr_accessor :angle
      attr_accessor :rotation_style

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        name = md2[1]
        context[:characters][name] = new(name: name, costumes: [md2[2]],
                                         x: md2[3], y: md2[4], angle: md2[5],
                                         rotation_style: md2[6] || 'free')

        true
      end

      def initialize(options)
        @name = options[:name]
        @costumes = options[:costumes]
        @x = options[:x]
        @y = options[:y]
        @angle = options[:angle]
        @rotation_style = options[:rotation_style]
      end

      def to_xml(parent)
        attrs = {
          'name' => @name,
          'x' => @x,
          'y' => @y,
          'angle' => @angle,
          'costumes' => @costumes.join(',')
        }
        attrs['rotation_style'] = @rotation_style if @rotation_style != 'free'
        parent.add_element('character', attrs)
      end
    end
  end
end

# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class MotionSetX < CharacterMethodCall
      blocknize '^\s*' + CHAR_RE + 'x\s*=\s*(\S+)\s*$',
                statement: true, inline: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        block = add_character_method_call_block(context, md2[1], new,
                                                X: md2[2])

        md3 = MotionSetY.regexp.match(context.look_next_line)
        process_motion_set_y(context, block, md3) if md3

        true
      end

      def self.process_motion_set_y(context, block, md)
        if block.character == get_character(context, md[1])
          process_value_string(context, block, md[2], :Y)
          context.next_line
        end
      rescue
        return
      end
      private_class_method :process_motion_set_y

      def type
        if @values.key?(:Y)
          'motion_set_x_y'
        else
          super
        end
      end
    end
  end
end

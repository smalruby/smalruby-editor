# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class MotionSetX < CharacterMethodCall
      blocknize '^\s*' + CHAR_RE + 'x\s*=\s*(\S+)\s*$',
                statement: true, inline: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        block = new
        _, context.current_block =
          *add_child_or_create_character_new_block(context, md2[1], block)
        process_value_string(context, block, md2[2], :X)

        md3 = MotionSetY.regexp.match(context.look_next_line)
        process_motion_set_y(context, block, md3) if md3

        true
      end

      def self.process_motion_set_y(context, block, md)
        name = md[1]
        name = context.receiver.try(:name) if !name || name == 'self'
        character = context.characters[name]
        return unless character

        if block.character == character
          process_value_string(context, block, md[2], :Y)
          context.next_line
        end
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

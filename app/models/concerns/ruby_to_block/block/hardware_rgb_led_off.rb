# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareRgbLedOff < CharacterMethodCall
      # rubocop:disable LineLength
      blocknize '^\s*(?:(\S+)\.)?rgb_led_(anode|cathode)\("(D[39])"\)\.off\s*$',
                statement: true
      # rubocop:enable LineLength

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        return false if !md2[1] && !context.receiver

        block = new(fields: { AC: md2[2], PIN: md2[3] })

        if md2[1]
          context.current_block =
            add_child_or_create_character_new_block(context, md2[1], block)
        else
          context.add_block(block)
        end

        true
      end
    end
  end
end

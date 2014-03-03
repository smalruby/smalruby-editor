# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareRgbLedOn < CharacterMethodCall
      # rubocop:disable LineLength
      blocknize '^\s*(?:(\S+)\.)?rgb_led_(anode|cathode)\("(D[39])"\).on\(color:\s*\[(\d+),\s*(\d+),\s*(\d+)\]\)\s*$',
                statement: true
      # rubocop:enable LineLength

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        return false if !md2[1] && !context.receiver

        color = [md2[4], md2[5], md2[6]].map(&:to_i)
        return false if color.any? { |c| c < 0 || c > 255 }

        color_code = '#' + color.map { |c| sprintf('%02x', c) }.join
        block = new(fields: { AC: md2[2], PIN: md2[3], COLOUR: color_code })

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

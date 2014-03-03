# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareRgbLedOn < Base
      # rubocop:disable LineLength
      blocknize '^\s*rgb_led_(anode|cathode)\("(D[39])"\).on\(color:\s*\[(\d+),\s*(\d+),\s*(\d+)\]\)\s*$',
                statement: true
      # rubocop:enable LineLength

      def self.process_match_data(md, context)
        return false unless context.receiver

        md2 = regexp.match(md[type])

        color = [md2[3], md2[4], md2[5]].map(&:to_i)
        return false if color.any? { |c| c < 0 || c > 255 }
        color_code = '#' + color.map { |c| sprintf('%02x', c) }.join

        fields = {
          AC: md2[1],
          PIN: md2[2],
          COLOUR: color_code
        }
        context.add_block(new(fields: fields))

        true
      end
    end
  end
end

# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareRgbLedOff < Base
      blocknize '^\s*rgb_led_(anode|cathode)\("(D[39])"\)\.off\s*$',
                statement: true

      def self.process_match_data(md, context)
        return false unless context.receiver

        md2 = regexp.match(md[type])
        fields = {
          AC: md2[1],
          PIN: md2[2],
        }
        context.add_block(new(fields: fields))

        true
      end
    end
  end
end

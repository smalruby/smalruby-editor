# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareSmalrubotS1DcMotorSetPowerRatio < CharacterMethodCall
      include HardwareOperation

      blocknize '^\s*' + CHAR_RE +
                'smalrubot_s1\.' +
                LOR_RE + '_dc_motor_power_ratio\s*=\s*(\S+)\s*$',
                statement: true, inline: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        add_character_method_call_block(context, md2[1],
                                        new(fields: { LOR: md2[2] }),
                                        SPEED: md2[3])
        true
      end
    end
  end
end

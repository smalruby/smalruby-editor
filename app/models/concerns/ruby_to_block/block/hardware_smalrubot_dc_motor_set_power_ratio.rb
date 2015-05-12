# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareSmalrubotDcMotorSetPowerRatio < CharacterMethodCall
      include HardwareOperation

      blocknize ['^\s*',
                 CHAR_RE,
                 SMALRUBOT_RE, '\.',
                 LOR_RE, '_dc_motor_power_ratio\s*=\s*(\S+)',
                 '\s*$'].join(''),
                statement: true, inline: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        block = new(fields: { LOR: md2[3] })
        block.smalrubot_name = md2[2]
        add_character_method_call_block(context, md2[1], block, SPEED: md2[4])
        true
      end
    end
  end
end

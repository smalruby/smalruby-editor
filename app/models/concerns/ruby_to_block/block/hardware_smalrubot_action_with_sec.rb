# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareSmalrubotActionWithSec < CharacterMethodCall
      include HardwareOperation

      # rubocop:disable LineLength
      blocknize ['^\s*',
                 CHAR_RE,
                 SMALRUBOT_RE, '\.',
                 ACTION_RE, '\(\s*sec:\s*(\d+(?:\.\d+)?)\)',
                 '\s*$'].join(''),
                statement: true, inline: true
      # rubocop:enable LineLength

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        block = new(fields: { ACTION: md2[3] })
        block.smalrubot_name = md2[2]
        add_character_method_call_block(context, md2[1], block, SEC: md2[4])
        true
      end
    end
  end
end

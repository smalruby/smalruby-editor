# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareSmalrubotV3ActionWithSec < CharacterMethodCall
      include HardwareOperation

      # rubocop:disable LineLength
      blocknize '^\s*' + CHAR_RE +
                'smalrubot_v3\.' + ACTION_RE +
                '\(\s*sec:\s*(\d+(?:\.\d+)?)\)' +
                '\s*$',
                statement: true, inline: true
      # rubocop:enable LineLength

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        add_character_method_call_block(context, md2[1],
                                        new(fields: { ACTION: md2[2] }),
                                        SEC: md2[3])
        true
      end
    end
  end
end

# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareSmalrubotV3Action < CharacterMethodCall
      include HardwareOperation

      # rubocop:disable LineLength
      blocknize '^\s*' + CHAR_RE +
                'smalrubot_v3\.' + ACTION_RE +
                '\s*$',
                statement: true, inline: true
      # rubocop:enable LineLength

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        add_character_method_call_block(context, md2[1],
                                        new(fields: { ACTION: md2[2] }))
        true
      end
    end
  end
end

# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class LooksSwitchCostume < CharacterMethodCall
      blocknize ['^\s*',
                 CHAR_RE,
                 'switch_costume\(', STRING_RE, '\)',
                 '\s*$'].join(""),
                statement: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        block = new(fields: { COSTUME: md2[2][1..-2] })
        _, context.current_block =
          *add_child_or_create_character_new_block(context, md2[1], block)

        true
      end
    end
  end
end

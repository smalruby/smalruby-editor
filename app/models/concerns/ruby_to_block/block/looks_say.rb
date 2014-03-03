# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class LooksSay < CharacterMethodCall
      blocknize '^\s*(?:(\S+)\.)?say\(message:\s*("[^"]*")\)\s*$',
                statement: true, inline: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        block = new

        character_new_block, how =
          *add_child_or_create_character_new_block(context, md2[1], block)
        return false unless character_new_block

        process_value_string(context, block, md2[2], 'TEXT')

        if how == :create
          context.current_block = character_new_block
        else
          context.current_block = block
        end

        true
      end
    end
  end
end

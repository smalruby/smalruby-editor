module RubyToBlock
  module Block
    class EventsOnClick < CharacterEvent
      blocknize '^\s*' + CHAR_RE + 'on\(:click\)\s+do\s*$',
                statement: true, indent: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        do_block = Block.new('null')
        block = new(statements: { DO: do_block })

        character_new_block =
          add_child_or_create_character_new_block(context, md2[1], block)

        context.statement_stack.push([type, character_new_block])
        context.current_block = do_block

        true
      end
    end
  end
end

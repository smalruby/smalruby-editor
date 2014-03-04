module RubyToBlock
  module Block
    class EventsOnStart < CharacterEvent
      blocknize '^\s*' + CHAR_RE + 'on\(:start\)\s+do\s*$',
                statement: true, indent: true

      def self.process_match_data(md, context)
        do_block = Block.new('null')
        block = new(statements: { DO: do_block })

        md2 = regexp.match(md[type])
        character_new_block =
          add_child_or_create_character_new_block(context, md2[1], block)

        context.statement_stack.push([type, character_new_block])
        context.current_block = do_block

        true
      end
    end
  end
end

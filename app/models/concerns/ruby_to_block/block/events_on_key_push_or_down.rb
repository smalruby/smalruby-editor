module RubyToBlock
  module Block
    class EventsOnKeyPushOrDown < CharacterEvent
      blocknize '^\s*(?:(\S+)\.)?on\(:key_(down|push),\s*([^),]+)\)\s+do\s*$',
                statement: true, indent: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        do_block = Block.new('null')
        block = new(fields: { KEY: md2[3], POD: md2[2] },
                    statements: { DO: do_block })

        character_new_block =
          add_child_or_create_character_new_block(context, md2[1], block)

        context.statement_stack.push([type, character_new_block])
        context.current_block = do_block

        true
      end
    end
  end
end

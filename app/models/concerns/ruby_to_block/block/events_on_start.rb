module RubyToBlock
  module Block
    class EventsOnStart < Base
      blocknize '^\s*(?:(\S+)\.)?on\(:start\)\ do$',
                statement: true, indent: true

      def self.process_match_data(md, context)
        md2 = Block.regexp(type).match(md[type])
        name = md2[1] ? md2[1] : context.receiver_stack.last.name
        c = context.characters[name]
        context.character_stack.push(c)

        do_block = Block.new('null')
        events_on_start_block = new(statements: { DO: do_block })

        character_new_block =
          process_match_data_add_block(context,
                                       name, c, events_on_start_block)

        context.statement_stack.push([:events_on_start, character_new_block])
        context.receiver_stack.push(c)

        context.current_block = do_block

        true
      end

      # rubocop:disable CyclomaticComplexity

      def self.process_match_data_add_block(context, name, character, block)
        cb = context.current_block

        if cb && cb.type == 'character_new' && cb[:NAME] == name
          cb.add_statement(:DO, block)

          return cb
        end

        if character == context.receiver_stack.last
          cb.sibling = block

          return cb.parent
        end

        character_new_block = Block.new('character_new',
                                        fields: { NAME: name },
                                        statements: { DO: block })
        if cb && cb.type != 'character_new'
          cb.sibling = character_new_block
        else
          context.blocks.push(character_new_block)
        end

        character_new_block
      end

      private_class_method :process_match_data_add_block

      # rubocop:enable CyclomaticComplexity
    end
  end
end

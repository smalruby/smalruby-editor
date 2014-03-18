module RubyToBlock
  module Block
    class CharacterEvent < CharacterMethodCall
      def self.process_end(context)
        context.receiver_stack.pop
        context.character_stack.pop
        super
      end

      def self.add_character_event_blocks(context, name, block)
        do_block = Block.new('null')
        block.add_statement(:DO, do_block)

        character = get_character(context, name)
        context.character_stack.push(character)

        character_new_block, _ =
          add_child_or_create_character_new_block(context, name, block)

        context.receiver_stack.push(character)

        context.statement_stack.push([type, character_new_block])
        context.current_block = do_block
      end
    end
  end
end

module RubyToBlock
  module Block
    class Event < Base
      def self.process_end(context)
        context.receiver_stack.pop
        context.character_stack.pop
        super
      end

      def self.add_child_or_create_character_new_block(context, name, block)
        name = context.receiver.name unless name
        character = context.characters[name]
        context.character_stack.push(character)

        cb = context.current_block
        if cb && cb.type == 'character_new' && cb[:NAME] == name
          cb.add_statement(:DO, block)
          character_new_block = cb
        elsif character == context.receiver
          cb.sibling = block
          character_new_block = cb.parent
        else
          character_new_block =
            create_character_new_block(context, name, block)
        end

        context.receiver_stack.push(character)

        character_new_block
      end
      private_class_method :add_child_or_create_character_new_block

      def self.create_character_new_block(context, name, block)
        character_new_block = Block.new('character_new',
                                        fields: { NAME: name },
                                        statements: { DO: block })
        cb = context.current_block
        if cb && cb.type != 'character_new'
          cb.sibling = character_new_block
        else
          context.blocks.push(character_new_block)
        end
        character_new_block
      end
      private_class_method :create_character_new_block
    end
  end
end

module RubyToBlock
  module Block
    class CharacterMethodCall < Base
      def self.add_child_or_create_character_new_block(context, name, block)
        name = context.receiver.try(:name) unless name
        character = context.characters[name]
        return nil unless character

        cb = context.current_block
        if cb && cb.type == 'character_new' && cb[:NAME] == name
          cb.add_statement(:DO, block)
          [cb, :add_statement]
        elsif character == context.receiver
          cb.sibling = block
          [cb.parent, :sibling]
        else
          [create_character_new_block(context, name, block), :create]
        end
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

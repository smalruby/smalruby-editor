module RubyToBlock
  module Block
    class CharacterMethodCall < Base
      include CharacterOperation

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        block = new
        _, context.current_block =
          *add_child_or_create_character_new_block(context, md2[1], block)

        true
      end

      # rubocop:disable CyclomaticComplexity

      def self.add_child_or_create_character_new_block(context, name, block)
        name = context.receiver.try(:name) if !name || name == 'self'
        character = context.characters[name]
        fail unless character

        block.character = character

        cb = context.current_block
        if cb && cb.type == 'character_new' && cb.character == character
          cb.add_statement(:DO, block)
          [cb, cb]
        elsif character == context.receiver
          cb.sibling = block
          [cb.parent, block]
        else
          character_new = create_character_new_block(context, character, block)
          [character_new, character_new]
        end
      end
      private_class_method :add_child_or_create_character_new_block

      # rubocop:enable CyclomaticComplexity

      def self.create_character_new_block(context, character, block)
        character_new_block = Block.new('character_new',
                                        fields: { NAME: character.name },
                                        statements: { DO: block })
        character_new_block.character = character

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

module RubyToBlock
  module Block
    class CharacterMethodCall < Base
      CHAR_RE = '(?:(\S+)\.)?'

      # rubocop:disable CyclomaticComplexity

      def self.add_child_or_create_character_new_block(context, name, block)
        name = context.receiver.try(:name) unless name
        character = context.characters[name]
        fail unless character

        cb = context.current_block
        if cb && cb.type == 'character_new' && cb[:NAME] == name
          cb.add_statement(:DO, block)
          [cb, block]
        elsif character == context.receiver
          cb.sibling = block
          [cb.parent, block]
        else
          character_new = create_character_new_block(context, name, block)
          [character_new, character_new]
        end
      end
      private_class_method :add_child_or_create_character_new_block

      # rubocop:enable CyclomaticComplexity

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

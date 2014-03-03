module RubyToBlock
  module Block
    class CharacterEvent < CharacterMethodCall
      def self.process_end(context)
        context.receiver_stack.pop
        context.character_stack.pop
        super
      end

      def self.add_child_or_create_character_new_block(context, name, block)
        name = context.receiver.try(:name) unless name
        character = context.characters[name]
        context.character_stack.push(character)

        character_new_block, _ = *super

        context.receiver_stack.push(character)

        character_new_block
      end
      private_class_method :add_child_or_create_character_new_block
    end
  end
end

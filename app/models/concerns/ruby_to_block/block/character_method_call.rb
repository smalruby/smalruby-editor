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

      def self.add_character_method_call_block(context, name, block,
                                               values = {})
        _, context.current_block =
          *add_child_or_create_character_new_block(context, name, block)

        values.each do |k, v|
          process_value_string(context, block, v, k)
        end

        block
      end
    end
  end
end

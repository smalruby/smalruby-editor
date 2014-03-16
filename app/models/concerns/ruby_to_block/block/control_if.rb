module RubyToBlock
  module Block
    class ControlIf < Base
      blocknize '^\s*if\s+(.*?)\s*$',
                statement: true, indent: true, inline: true

      def self.process_match_data(md, context)
        then_block = Block.new('null')
        block = new(statements: { THEN: then_block })

        if context.current_block
          context.current_block.sibling = block
        else
          context.blocks.push(block)
        end

        md2 = regexp.match(md[type])
        if (value_md = Block.value_regexp.match(md2[1]))
          context.current_block = block
          context.value_name_stack.push(:COND)
          Block.process_match_data(value_md, context)
          context.value_name_stack.pop
        end

        context.current_block = then_block

        context.statement_stack.push([type, block])

        true
      end

      def self.process_else(context)
        block = context.statement_block
        else_block = Block.new('null')
        block.add_statement(:ELSE, else_block)
        context.current_block = else_block

        true
      end

      def type
        if @statements.key?(:ELSE)
          'control_if_else'
        else
          super
        end
      end
    end
  end
end

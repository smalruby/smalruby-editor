module RubyToBlock
  module Block
    class ControlLoop < Base
      blocknize '^\s*loop\s+do\s*$', statement: true, indent: true

      def self.process_match_data(md, context)
        return false unless context.receiver

        do_block = Block.new('null')
        block = new(statements: { DO: do_block })
        context.statement_stack.push([type, block])
        context.current_block.sibling = block
        context.current_block = do_block

        true
      end
    end
  end
end

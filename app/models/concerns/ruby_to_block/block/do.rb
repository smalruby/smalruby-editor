module RubyToBlock
  module Block
    class Do < RubyStatement
      blocknize '^.*?\s*do\s*$',
                statement: true, priority: -1

      def self.process_match_data(md, context)
        block = new(fields: { STATEMENT: md.string })
        context.add_block(block)
        context.statement_stack.push([type, block])
        true
      end

      def self.process_end(context)
        context.add_block(new(fields: { STATEMENT: 'end' }))
        super
      end

      def type
        'ruby_statement'
      end
    end
  end
end

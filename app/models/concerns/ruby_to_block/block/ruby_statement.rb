module RubyToBlock
  module Block
    class RubyStatement < Base
      blocknize '^.*$', statement: true, priority: -Float::INFINITY

      def self.process_match_data(md, context)
        block = new(fields: { STATEMENT: md.string })
        context.add_block(block)

        true
      end

      def parent=(block)
        @parent = block
        @original_statement ||= @fields[:STATEMENT]
        @fields[:STATEMENT] =
          @original_statement.sub(/^ {0,#{indent_level * 2}}/, '')
      end
    end
  end
end

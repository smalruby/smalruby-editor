module RubyToBlock
  module Block
    class RubyStatement < Base
      blocknize '^.*$', statement: true, priority: -Float::INFINITY

      def self.process_match_data(md, context)
        block = new(fields: { STATEMENT: md.string })
        context.add_block(block)

        true
      end

      private

      def fields_to_xml(e)
        @fields[:STATEMENT] =
          @fields[:STATEMENT].sub(/^ {0,#{indent_level * 2}}/, '')

        super
      end
    end
  end
end

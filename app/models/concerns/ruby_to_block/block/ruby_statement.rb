module RubyToBlock
  module Block
    class RubyStatement < Base
      def parent=(block)
        @parent = block
        @original_statement ||= @fields[:STATEMENT]
        @fields[:STATEMENT] =
          @original_statement.sub(/^ {0,#{indent_level * 2}}/, '')
      end
    end
  end
end

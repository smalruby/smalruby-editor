# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class End < Base
      blocknize '^\s*end$', statement: true

      def self.process_match_data(md, context)
        # TODO: リファクタリング、2回まわさなくてもいけそうだね。
        ends_num = context[:lines].select { |l|
          md2 = Block.statement_regexp.match(l)
          md2 && md2[:end]
        }.length + 1
        ends_num -= context[:lines].select { |l|
          md2 = Block.statement_regexp.match(l)
          md2 && (md2[:events_on_start])
        }.length
        if (ss = context[:statement_stack].last) &&
            ends_num <= context[:statement_stack].length
          context.current_block = ss[1]
          case ss.first
          when :events_on_start
            context.receiver_stack.pop
            context.character_stack.pop
          end
          context.statement_stack.pop

          true
        else
          false
        end
      end
    end
  end
end

# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    # Null(何もない)ブロックを表現する
    class Null < Base
      def to_xml(parent)
        return nil unless @sibling

        @sibling.to_xml(parent)
      end

      def null?
        !@sibling
      end
    end
  end
end

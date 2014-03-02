# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class OperatorsFalse < Value
      blocknize '^\s*false\s*$', value: true
    end
  end
end

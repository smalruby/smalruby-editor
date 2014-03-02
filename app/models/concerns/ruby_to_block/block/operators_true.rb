# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class OperatorsTrue < Value
      blocknize '^\s*true\s*$', value: true
    end
  end
end

# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class MotionReachWall < Value
      blocknize '^\s*reach_wall\?\s*$', value: true
    end
  end
end

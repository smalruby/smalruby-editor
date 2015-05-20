# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareInitHardware < Base
      blocknize '^\s*init_hardware\s*$', statement: true
    end
  end
end

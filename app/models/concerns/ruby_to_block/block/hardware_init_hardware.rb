# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareInitHardware < Base
      blocknize '^\s*init_hardware\s*$', statement: true

      def self.process_match_data(md, context)
        context.blocks.push(new)

        true
      end
    end
  end
end

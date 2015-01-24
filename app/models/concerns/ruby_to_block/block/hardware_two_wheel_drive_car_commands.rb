# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareTwoWheelDriveCarCommands < Value
      include HardwareOperation

      blocknize '^\s*"' + ACTION_RE + '"\s*$',
                value: true, priority: 1

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        context.add_value(new(fields: { COMMAND: md2[1] }))
        true
      end
    end
  end
end

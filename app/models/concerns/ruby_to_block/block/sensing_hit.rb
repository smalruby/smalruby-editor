# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class SensingHit < Value
      blocknize '^\s*hit\?\(([^)]+)\)\s*$', value: true

      def self.process_match_data(md, context)
        return false unless context.receiver

        md2 = regexp.match(md[type])
        name = md2[1]
        name.strip!
        c = context.characters[name]

        return false unless c

        context.add_value(new(fields: { CHAR: name }))

        true
      end
    end
  end
end

# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class SoundPresetSounds < Value
      blocknize '^\s*"([^"]*?\.wav)"\s*$', value: true, priority: 1

      # TODO: 自動生成する
      SOUNDS = %w(
        piano_do.wav
        piano_re.wav
        piano_mi.wav
        piano_fa.wav
        piano_so.wav
        piano_ra.wav
        piano_si.wav
        piano_do_2.wav
      )

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        if SOUNDS.include?(md2[1])
          context.add_value(new(fields: { NAME: md2[1] }))
        else
          context.add_value(Text.new(fields: { TEXT: md2[1] }))
        end

        true
      end
    end
  end
end

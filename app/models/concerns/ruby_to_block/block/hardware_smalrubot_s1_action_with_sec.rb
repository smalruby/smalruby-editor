# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareSmalrubotS1ActionWithSec < HardwareSmalrubotV3ActionWithSec
      # rubocop:disable LineLength
      blocknize '^\s*' + CHAR_RE +
                'smalrubot_s1\.' + ACTION_RE +
                '\(\s*sec:\s*(\d+(?:\.\d+)?)\)' +
                '\s*$',
                statement: true, inline: true
      # rubocop:enable LineLength
    end
  end
end

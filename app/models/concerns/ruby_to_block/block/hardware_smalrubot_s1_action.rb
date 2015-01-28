# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareSmalrubotS1Action < HardwareSmalrubotV3Action
      # rubocop:disable LineLength
      blocknize '^\s*' + CHAR_RE +
                'smalrubot_s1\.' + ACTION_RE +
                '\s*$',
                statement: true, inline: true
      # rubocop:enable LineLength
    end
  end
end

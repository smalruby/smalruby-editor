# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    # キャラクターのメソッドや属性に共通するメソッドや定数を定義するモジュール
    module CharacterOperation
      CHAR_RE = '(?:(\S+)\.)?'

      attr_accessor :character
    end
  end
end

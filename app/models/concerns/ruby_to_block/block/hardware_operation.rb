# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    # ハードウェアのメソッドや属性に共通するメソッドや定数を定義するモジュール
    module HardwareOperation
      extend ActiveSupport::Concern

      SMALRUBOT_RE = '(smalrubot_[^.]+)'
      DIO_PIN_RE = '\s*"(D(?:[2-9]|10|11|12|13))"\s*'
      PWM_PIN_RE = '\s*"(D(?:3|5|6|9|10|11))"\s*'
      AIO_PIN_RE = '\s*"(A[0-5])"\s*'
      TWO_WHEEL_DRIVE_CAR_PIN_RE = '\s*"(D[56])"\s*'
      LOR_RE = '(left|right)'
      ON_OFF_RE = '(turn_on|turn_off)'
      POR_RE = '(pressed|released)'
      ACTION_RE = '(forward|backward|turn_left|turn_right|stop)'

      included do
        attr_accessor :smalrubot_name
      end

      def type
        @type ||=
          (smalrubot_name ? super.gsub('smalrubot', smalrubot_name) : super)
      end
    end
  end
end

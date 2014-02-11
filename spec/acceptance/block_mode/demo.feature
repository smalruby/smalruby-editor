# encoding: utf-8
# language: ja
@javascript
機能: Demo - デモモード
  シナリオ: デモ用のブロックからRubyのソースコードを生成する
    前提 "デモページ" にアクセスする

    もし "Rubyタブ" にタブを切り替える

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "car2.png", x: 0, y: 0, angle: 0)
    car2 = Character.new(costume: "car3.png", x: 0, y: 415, angle: 0)
    # 逃げる車

    car1.on(:start) do
      loop do
        move(6)
        if reach_wall?
          turn
        end
      end
    end

    car1.on(:key_down, K_LEFT) do
      rotate(-15)
    end

    car1.on(:key_down, K_RIGHT) do
      rotate(15)
    end

    # 追いかける車

    car2.on(:start) do
      loop do
        point_towards(car1)
        move(3)
        if hit?(car1)
          say(message: "追いつきました！")
        else
          say(message: "")
        end
      end
    end

    """

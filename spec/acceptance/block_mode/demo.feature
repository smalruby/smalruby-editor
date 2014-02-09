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

    car1 = Character.new(costume: "car1.png", x: 264, y: 178, angle: 0)
    car2 = Character.new(costume: "car4.png", x: 0, y: 0, angle: 90)

    car1.on(:start) do
      loop do
        move(10)
        if reach_wall?
          turn
        end
      end
    end

    car1.on(:click) do
      car2.x = x
      car2.y = y

      car2.on(:start) do
        loop do
          move(10)
          if reach_wall?
            turn
          end
        end
      end
    end

    """

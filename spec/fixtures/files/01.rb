# -*- coding: utf-8 -*-
# 画面をクリックして隠れている車を1台探してみよう

require "smalruby"

# ＜プログラム＞             # ＜説明＞
canvas1 = Canvas.new         # 背景を用意する
car1 = Character.new(x: 0, y: 148, costume: "car3.png", visible: true)
                             # 車を用意する (最初に隠しておく)

# ＜プログラム＞             # ＜説明＞
canvas1.on(:start) do        # (背景は) 始まったとき
  draw_font(x: 0, y: 0,
            string: "画面をクリックして隠れている車を探してね",
            size: 32)        # (0, 0) に (32) の大きさで
                             # 「画面をクリックして隠れている車を探してね」の
                             # 文章を表示する
  draw_font(x: 0, y: 32,
            string: "ヒント：線の少し上だよ",
            size: 24)        # (0, 32) に (24) の大きさで
                             # 「ヒント：線の少し上だよ」の
                             # 文章を表示する
  box_fill(x1: 0, y1: 200,
           x2: 639, y2: 204,
           color: "red")   # (0, 200)-(639, 204) の四角を
                             # (white) 色で塗りつぶす
end

# ＜プログラム＞             # ＜説明＞
canvas1.on(:click) do |x, y| # (背景は) クリックしたとき
  canvas2 = Canvas.new(x: x - 9, y: y - 9, width: 20, height: 20)
                             # (お絵かき) を用意する
  canvas2.on(:start) do      # >> (お絵かきは) 始まったとき
    circle_fill(x: 9, y: 9, r: 9, color: "white")
                             # >> (9, 9)、半径9の円をwhite色で塗りつぶす
    sleep(0.5)               # >> (0.5) 秒待つ
    vanish                   # >> (お絵かきを) 取り除く
  end
end

# ＜プログラム＞             # ＜説明＞
car1.on(:start) do           # (車は) プログラムが始まったとき
  speed = rand(10..20)        # (speed) を (5～10までのランダム) にする
  loop do                    # ずっと
    move(speed)              # >> (speed) 歩動かす
    turn_if_reach_wall       # >> もし端に着いたら、跳ね返る
  end
end

# ＜プログラム＞             # ＜説明＞
car1.on(:click) do           # (車は) クリックしたとき
  if self.visible == false   # もし (隠している) だったら
    self.visible = true      # >> 表示する
  else                       # そうでなければ
    self.visible = false     # >> 隠す
  end
end

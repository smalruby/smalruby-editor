# encoding: utf-8
# language: ja
@javascript
@debug
機能: Character Dialog - キャラクターダイアログ
  背景:
    前提 'ブロック' タブを表示する
    かつ '#add-character-button' をクリックする
    かつ JavaScriptによる処理が終わるまで待つ

    ならば '#character-modal' が表示されていること

  シナリオ: キャラクターの一覧を表示する
    ならば '.thumbnails' が表示されていること
    かつ '.thumbnails' に次の要素が表示されていること:
      | selecter                                                   |
      | img[alt="car1.png"][src="/smalruby/assets/car1.png"]       |
      | img[alt="car2.png"][src="/smalruby/assets/car2.png"]       |
      | img[alt="car3.png"][src="/smalruby/assets/car3.png"]       |
      | img[alt="car4.png"][src="/smalruby/assets/car4.png"]       |
      | img[alt="cat1.png"][src="/smalruby/assets/cat1.png"]       |
      | img[alt="cat2.png"][src="/smalruby/assets/cat2.png"]       |
      | img[alt="cat3.png"][src="/smalruby/assets/cat3.png"]       |
      | img[alt="ball1.png"][src="/smalruby/assets/ball1.png"]     |
      | img[alt="ball2.png"][src="/smalruby/assets/ball2.png"]     |
      | img[alt="ball3.png"][src="/smalruby/assets/ball3.png"]     |
      | img[alt="ball4.png"][src="/smalruby/assets/ball4.png"]     |
      | img[alt="ryu1.png"][src="/smalruby/assets/ryu1.png"]       |
      | img[alt="ryu2.png"][src="/smalruby/assets/ryu2.png"]       |
      | img[alt="taichi1.png"][src="/smalruby/assets/taichi1.png"] |
      | img[alt="taichi2.png"][src="/smalruby/assets/taichi2.png"] |
    かつ '.thumbnails a.active img[alt="car1.png"]' が表示されていること

  シナリオ: キャラクターのコスチュームを変更する
    もし '.thumbnails li a img[src="/smalruby/assets/ryu1.png"]' をクリックする
    かつ '#character-modal-ok-button' をクリックする
    かつ JavaScriptによる処理が終わるまで待つ

    ならば '#character-selector-character-set .item:nth-child(1) .item-info .name' に文字 'ryu1' が表示されていること
    かつ '#character-selector-character-set .item:nth-child(1)' に 'img[src="/smalruby/assets/ryu1.png"]' が表示されていること

    もし '#character-selector-character-set .item:nth-child(1) a.character' をクリックする
    かつ JavaScriptによる処理が終わるまで待つ

    ならば '#character-modal' が表示されていること
    かつ '.thumbnails a.active img[alt="ryu1.png"]' が表示されていること

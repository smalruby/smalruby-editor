# encoding: utf-8
# language: ja
@javascript
@standalone
@open_on_error
機能: Character Dialog - キャラクターダイアログ
  背景:
    前提 '/' にアクセスする
    かつ ログインする
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

    かつ '#character-modal-costume-set .item:nth-child(1) .name' に文字 'costume1' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(1) .attributes' に文字 '1' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(1) a.remove-button' が表示されていないこと

    かつ 'costume[name]' フィールドの値が "costume1" であること

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
    かつ 'costume[name]' フィールドの値が "costume1" であること

  シナリオ: キャラクターのコスチュームを追加・削除する
    もし '#character-modal-add-costume-button' をクリックする

    ならば '#character-modal-costume-set .item:nth-child(1) .name' に文字 'costume1' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(1) .attributes' に文字 '1' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(1) a.remove-button' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(2) .name' に文字 'costume2' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(2) .attributes' に文字 '2' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(2) a.remove-button' が表示されていること
    かつ 'costume[name]' フィールドの値が "costume2" であること
    かつ '.thumbnails a.active img[alt="car1.png"]' が表示されていること

    もし '.thumbnails li a img[src="/smalruby/assets/ryu1.png"]' をクリックする

    ならば '.thumbnails a.active img[alt="ryu1.png"]' が表示されていること

    もし '#character-modal-add-costume-button' をクリックする

    ならば '#character-modal-costume-set .item:nth-child(1) .name' に文字 'costume1' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(1) .attributes' に文字 '1' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(1) a.remove-button' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(2) .name' に文字 'costume2' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(2) .attributes' に文字 '2' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(2) a.remove-button' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(3) .name' に文字 'costume3' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(3) .attributes' に文字 '3' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(3) a.remove-button' が表示されていること
    かつ 'costume[name]' フィールドの値が "costume3" であること
    かつ '.thumbnails a.active img[alt="ryu1.png"]' が表示されていること

    もし '#character-modal-ok-button' をクリックする
    かつ JavaScriptによる処理が終わるまで待つ
    かつ '#character-selector-character-set .item:nth-child(1) a.character' をクリックする
    かつ JavaScriptによる処理が終わるまで待つ

    ならば '#character-modal' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(1) .name' に文字 'costume1' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(1) .attributes' に文字 '1' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(1) a.remove-button' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(2) .name' に文字 'costume2' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(2) .attributes' に文字 '2' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(2) a.remove-button' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(3) .name' に文字 'costume3' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(3) .attributes' に文字 '3' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(3) a.remove-button' が表示されていること
    かつ 'costume[name]' フィールドの値が "costume3" であること
    かつ '.thumbnails a.active img[alt="ryu1.png"]' が表示されていること

    もし '#character-modal-costume-set .item:nth-child(1) a.remove-button' をクリックする

    ならば '#character-modal-costume-set .item:nth-child(1) .name' に文字 'costume2' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(1) .attributes' に文字 '1' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(1) a.remove-button' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(2) .name' に文字 'costume3' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(2) .attributes' に文字 '2' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(2) a.remove-button' が表示されていること
    かつ 'costume[name]' フィールドの値が "costume3" であること
    かつ '.thumbnails a.active img[alt="ryu1.png"]' が表示されていること

    もし '#character-modal-costume-set .item:nth-child(2) a.remove-button' をクリックする

    ならば '#character-modal-costume-set .item:nth-child(1) .name' に文字 'costume2' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(1) .attributes' に文字 '1' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(1) a.remove-button' が表示されていないこと
    かつ 'costume[name]' フィールドの値が "costume2" であること
    かつ '.thumbnails a.active img[alt="ryu1.png"]' が表示されていること

    もし '#character-modal-ok-button' をクリックする
    かつ JavaScriptによる処理が終わるまで待つ
    かつ '#character-selector-character-set .item:nth-child(1) a.character' をクリックする
    かつ JavaScriptによる処理が終わるまで待つ

    ならば '#character-modal' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(1) .name' に文字 'costume2' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(1) .attributes' に文字 '1' が表示されていること
    かつ '#character-modal-costume-set .item:nth-child(1) a.remove-button' が表示されていないこと
    かつ 'costume[name]' フィールドの値が "costume2" であること
    かつ '.thumbnails a.active img[alt="ryu1.png"]' が表示されていること

  @target
  シナリオ: キャラクターのコスチュームをアップロードする
    前提 '#character-modal a#character-modal-upload-costume' が表示されていること

    もし 'character-modal-upload-costume-file' フィールドにファイル 'files/extra_car.png' を設定する
    かつ JavaScriptによる処理が終わるまで待つ

    ならば ホームディレクトリに '1102/__assets__/extra_car.png' が存在すること
    かつ '#character-modal-costume-selector .thumbnails li:nth-child(1) img[alt="extra_car.png"][src="/smalruby/assets/extra_car.png"]' が表示されていること
    かつ '#character-modal-costume-selector .thumbnails li:nth-child(1) a.remove-button' が表示されていること

    もし '#character-modal-costume-selector img[alt="extra_car.png"]' をクリックする

    ならば '#character-modal-character img[alt="extra_car.png"][src="/smalruby/assets/extra_car.png"]' が表示されていること
    かつ '#character-modal-costume-set > .item:nth-child(1) img[alt="extra_car.png"][src="/smalruby/assets/extra_car.png"]' が表示されていること

    もし '#character-modal-ok-button' をクリックする
    かつ JavaScriptによる処理が終わるまで待つ

    ならば '#character-selector-character-set > .item:nth-child(1) img[src="/smalruby/assets/extra_car.png"]' が表示されていること

    もし '#character-selector-character-set > .item:nth-child(1) img[src="/smalruby/assets/extra_car.png"]' をクリックする
    かつ JavaScriptによる処理が終わるまで待つ

    ならば '#character-modal-costume-selector .thumbnails li:nth-child(1) img[alt="extra_car.png"][src="/smalruby/assets/extra_car.png"]' が表示されていること
    かつ '#character-modal-costume-selector .thumbnails li:nth-child(1) a.remove-button' が表示されていること
    かつ '#character-modal-character img[alt="extra_car.png"][src="/smalruby/assets/extra_car.png"]' が表示されていること
    かつ '#character-modal-costume-set > .item:nth-child(1) img[alt="extra_car.png"][src="/smalruby/assets/extra_car.png"]' が表示されていること

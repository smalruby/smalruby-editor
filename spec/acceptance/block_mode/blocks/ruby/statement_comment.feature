# encoding: utf-8
# language: ja
@javascript
機能: ruby_{statement,comment} - 「{文,コメント}」ブロック
  背景:
    前提 "ブロック" タブを表示する

  シナリオテンプレート: ブロックのみ配置する
    もし 次のブロック("ruby_<ブロック名のサフィックス>")を配置する:
      """
      %block{:type => "ruby_<ブロック名のサフィックス>", :x => "0", :y => "0", :inline => "true"}
        %field{:name => "<フィールド名>"}<
          stage1 = Stage.new(color: "white")
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      <Ruby>
      """

  例:
    | ブロック名のサフィックス | フィールド名 | Ruby                                 |
    | statement                | STATEMENT    | stage1 = Stage.new(color: "white")   |
    | comment                  | COMMENT      | # stage1 = Stage.new(color: "white") |

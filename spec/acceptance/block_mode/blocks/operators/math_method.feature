# encoding: utf-8
# language: ja
@javascript
機能: operators_math_method - 「変数:(　)の[▼数学関数]」ブロック
  背景:
    前提 "ブロック" タブを表示する

  シナリオテンプレート: ブロックのみ配置する
    もし 次のブロック("METHOD=<method>")を配置する:
      """
      %block{:type => "operators_math_method", :x => "0", :y => "0", :inline => "true"}
        %field{:name => "METHOD"}<
          \<method>
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      <Ruby>
      """

    例:
      | method            | Ruby          |
      | %num%.abs         | 0.abs         |
      | %num%.floor       | 0.floor       |
      | %num%.ceil        | 0.ceil        |
      | Math.sqrt(%num%)  | Math.sqrt(0)  |
      | Math.sin(%num%)   | Math.sin(0)   |
      | Math.cos(%num%)   | Math.cos(0)   |
      | Math.tan(%num%)   | Math.tan(0)   |
      | Math.asin(%num%)  | Math.asin(0)  |
      | Math.acos(%num%)  | Math.acos(0)  |
      | Math.atan(%num%)  | Math.atan(0)  |
      | Math.log(%num%)   | Math.log(0)   |
      | Math.log10(%num%) | Math.log10(0) |
      | Math::E ** %num%  | Math::E ** 0  |
      | 10 ** %num%       | 10 ** 0       |

  シナリオテンプレート: 値を設定したブロックを配置する
    もし 次のブロック("METHOD=<method>")を配置する:
      """
      %block{:type => "operators_math_method", :x => "0", :y => "0", :inline => "true"}
        %value{:name => "NUM"}
          %block{:type => "math_number"}
            %field{:name => "NUM"}<
              10
        %field{:name => "METHOD"}<
          \<method>
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      <Ruby>
      """

    例:
      | method            | Ruby           |
      | %num%.abs         | 10.abs         |
      | %num%.floor       | 10.floor       |
      | %num%.ceil        | 10.ceil        |
      | Math.sqrt(%num%)  | Math.sqrt(10)  |
      | Math.sin(%num%)   | Math.sin(10)   |
      | Math.cos(%num%)   | Math.cos(10)   |
      | Math.tan(%num%)   | Math.tan(10)   |
      | Math.asin(%num%)  | Math.asin(10)  |
      | Math.acos(%num%)  | Math.acos(10)  |
      | Math.atan(%num%)  | Math.atan(10)  |
      | Math.log(%num%)   | Math.log(10)   |
      | Math.log10(%num%) | Math.log10(10) |
      | Math::E ** %num%  | Math::E ** 10  |
      | 10 ** %num%       | 10 ** 10       |

  シナリオテンプレート: 文と値を設定したブロックを配置する
    もし 次のブロック("METHOD=<method>")を配置する:
      """
      %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true"}
        %value{:name => "ARG"}
          %block{:type => "operators_math_method"}
            %value{:name => "NUM"}
              %block{:type => "math_number"}
                %field{:name => "NUM"}<
                  10
            %field{:name => "METHOD"}<
              \<method>
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      p(<Ruby>)
      """

    例:
      | method            | Ruby           |
      | %num%.abs         | 10.abs         |
      | %num%.floor       | 10.floor       |
      | %num%.ceil        | 10.ceil        |
      | Math.sqrt(%num%)  | Math.sqrt(10)  |
      | Math.sin(%num%)   | Math.sin(10)   |
      | Math.cos(%num%)   | Math.cos(10)   |
      | Math.tan(%num%)   | Math.tan(10)   |
      | Math.asin(%num%)  | Math.asin(10)  |
      | Math.acos(%num%)  | Math.acos(10)  |
      | Math.atan(%num%)  | Math.atan(10)  |
      | Math.log(%num%)   | Math.log(10)   |
      | Math.log10(%num%) | Math.log10(10) |
      | Math::E ** %num%  | Math::E ** 10  |
      | 10 ** %num%       | 10 ** 10       |

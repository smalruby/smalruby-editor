# encoding: utf-8

step ':block_type ブロックを配置する' do |block_type|
  xml = escape_javascript(<<-XML)
    <xml xmlns="http://www.w3.org/1999/xhtml">
      <block type="#{h block_type}" inline="false" x="0" y="0"></block>
    </xml>
  XML

  page.execute_script(<<-JS)
    do {
      var dom = Blockly.Xml.textToDom('#{xml}');
      Blockly.Xml.domToWorkspace(Blockly.mainWorkspace, dom);
    } while (false);
  JS
end

step 'ブロックからソースコードを生成する' do
  step '"Rubyタブ" にタブを切り替える'
end

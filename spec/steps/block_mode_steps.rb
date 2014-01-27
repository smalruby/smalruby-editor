# encoding: utf-8

step ':block_type ブロックを配置する' do |block_type|
  block = REXML::Element.new('block')
  block.attributes['type'] = block_type
  block.attributes['inline'] = 'false'
  block.attributes['x'] = 0
  block.attributes['y'] = 0

  @blocks ||= []
  @blocks << block
end

step 'そのブロックの :value_name フィールドに' \
     '値が :field_value の :block_type ブロックを配置する' do
  |value_name, field_value, block_type|
  case block_type
  when '数値'
    child_block_type = 'math_number'
    field_name = 'NUM'
  when 'テキスト'
    child_block_type = 'text'
    field_name = 'TEXT'
  end

  block = @blocks.last

  value = REXML::Element.new('value')
  value.attributes['name'] = value_name
  block.add_element(value)

  child_block = REXML::Element.new('block')
  child_block.attributes['type'] = child_block_type
  value.add_element(child_block)

  field = REXML::Element.new('field')
  field.attributes['name'] = field_name
  field.text = field_value
  child_block.add_element(field)
end

step 'ブロックからソースコードを生成する' do
  xml = REXML::Document.new('<xml xmlns="http://www.w3.org/1999/xhtml" />')
  @blocks.each do |block|
    xml.root.add_element(block)
  end
  @blocks = []

  page.execute_script(<<-JS)
    do {
      var dom = Blockly.Xml.textToDom('#{escape_javascript(xml.to_s)}');
      Blockly.Xml.domToWorkspace(Blockly.mainWorkspace, dom);
    } while (false);
  JS

  step '"Rubyタブ" にタブを切り替える'
end

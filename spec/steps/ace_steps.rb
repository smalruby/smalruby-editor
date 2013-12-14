# encoding: utf-8

text_editor = 'テキストエディタ'

step 'テキストエディタにフォーカスがあること' do
  expect(page.evaluate_script(<<-JS)).to be_true
    $('#{$name_info[text_editor][:selector]} textarea.ace_text-input').get(0) == document.activeElement
  JS
end

step 'テキストエディタの :row 行目の :column 文字目にカーソルがあること' do |row, column|
  get_cursor_position_js =
    "ace.edit('#{$name_info[text_editor][:id]}').getCursorPosition()"
  expect(page.evaluate_script("#{get_cursor_position_js}.row")).to eq(row.to_i)
  expect(page.evaluate_script("#{get_cursor_position_js}.column")).to eq(column.to_i)
end

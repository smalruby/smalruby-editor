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

step 'テキストエディタに :program を入力済みである' do |program|
  send 'テキストエディタにプログラムを入力済みである:', program
end

step 'テキストエディタにプログラムを入力済みである:' do |program|
  page.execute_script(<<-JS)
    ace.edit('#{$name_info[text_editor][:id]}')
      .getSession()
      .getDocument()
      .setValue('#{program.gsub(/'/, "\\\\'")}')
  JS
end

step 'テキストエディタに :filename を読み込むこと' do |filename|
  expect(page.evaluate_script(<<-JS)).to eq(Pathname(fixture_path).join(filename).read)
    ace.edit('#{$name_info[text_editor][:id]}')
      .getSession()
      .getDocument()
      .getValue()
  JS
end

step 'テキストエディタのプログラムは以下であること:' do |program|
  expect(page.evaluate_script(<<-JS)).to eq(program)
    ace.edit('#{$name_info[text_editor][:id]}')
      .getSession()
      .getDocument()
      .getValue()
  JS
end

step 'テキストエディタのプログラムは :program であること' do |program|
  expect(page.evaluate_script(<<-JS)).to eq(program)
    ace.edit('#{$name_info[text_editor][:id]}')
      .getSession()
      .getDocument()
      .getValue()
  JS
end

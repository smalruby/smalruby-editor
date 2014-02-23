# encoding: utf-8

text_editor = 'テキストエディタ'

step 'テキストエディタにフォーカスがあること' do
  expect(page.evaluate_script(<<-JS)).to be_true
    ace.edit('#{NAME_INFO[text_editor][:id]}').isFocused()
  JS
end

step 'テキストエディタの :row 行目の :column 文字目にカーソルがあること' do |row, column|
  get_cursor_position_js =
    "ace.edit('#{NAME_INFO[text_editor][:id]}').getCursorPosition()"
  expect(page.evaluate_script("#{get_cursor_position_js}.row")).to eq(row.to_i)
  expect(page.evaluate_script("#{get_cursor_position_js}.column"))
    .to eq(column.to_i)
end

step 'テキストエディタに :program を入力済みである' do |program|
  send 'テキストエディタにプログラムを入力済みである:', program
end

step 'テキストエディタにプログラムを入力済みである:' do |program|
  page.execute_script(<<-JS)
    ace.edit('#{NAME_INFO[text_editor][:id]}')
      .getSession()
      .getDocument()
      .setValue('#{program.gsub(/'/, "\\\\'").gsub(/\r?\n/, '\n')}')
  JS
end

step 'テキストエディタに :filename を読み込むこと' do |filename|
  js = <<-JS
    ace.edit('#{NAME_INFO[text_editor][:id]}')
      .getSession()
      .getDocument()
      .getValue()
  JS
  path = Pathname(fixture_path).join(filename)
  expect(page.evaluate_script(js)).to eq(path.read)
end

step 'テキストエディタのプログラムは以下であること:' do |program|
  expect(page.evaluate_script(<<-JS)).to eq(program)
    ace.edit('#{NAME_INFO[text_editor][:id]}')
      .getSession()
      .getDocument()
      .getValue()
  JS
end

step 'テキストエディタのプログラムは以下を含むこと:' do |program|
  expect(page.evaluate_script(<<-JS)).to include(program)
    ace.edit('#{NAME_INFO[text_editor][:id]}')
      .getSession()
      .getDocument()
      .getValue()
  JS
end

step 'テキストエディタのプログラムは以下を含まないこと:' do |program|
  expect(page.evaluate_script(<<-JS)).not_to include(program)
    ace.edit('#{NAME_INFO[text_editor][:id]}')
      .getSession()
      .getDocument()
      .getValue()
  JS
end

step 'テキストエディタのプログラムは :program であること' do |program|
  expect(page.evaluate_script(<<-JS)).to eq(program)
    ace.edit('#{NAME_INFO[text_editor][:id]}')
      .getSession()
      .getDocument()
      .getValue()
  JS
end

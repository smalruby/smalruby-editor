# encoding: utf-8

step ':name にアクセスする' do |name|
  name_path = {
    'トップページ' => '/',
  }
  visit name_path[name]
end

step ':name が表示されていること' do |name|
  name_selector = {
    'Rubyタブ' => '#ruby-tab',
    'テキストエディタ' => '#text-editor',
    'プログラム名の入力欄' => '#filename',
    'セーブボタン' => '#save-button',
  }
  expect(page).to have_selector(name_selector[name])
end

step ':name 画面を表示する' do |name|
  name_path = {
    'エディタ' => '/',
  }
  visit name_path[name]
end

step 'テキストエディタにプログラムを入力済みである:' do |source|
  page.execute_script("ace.edit('text-editor').insert('#{source}');")
end

step 'プログラムの名前に :filename を指定する' do |filename|
  fill_in('filename', with: filename)
end

step ':name をクリックする' do |name|
  name_button = {
    'セーブボタン' => 'save-button',
  }
  click_button(name_button[name])
end

step ':filename をダウンロードする' do |filename|
  expect(page.response_headers['Content-Disposition'])
    .to eq("attachment; filename=\"#{filename}\"")
  expect(page.response_headers['Content-Type'])
    .to eq('text/plain; charset=utf-8')
end

step 'ダウンロードしたファイルの内容が正しい:' do |source|
  # expect(page.source).to eq(source)
end

# encoding: utf-8

name_info = {
  'トップページ' => {
    path: '/',
  },
  'エディタ' => {
    path: '/',
  },

  'Rubyタブ' => {
    id: 'ruby-tab',
    selector: '#ruby-tab',
  },
  'テキストエディタ' => {
    id: 'text-editor',
    selector: '#text-editor',
  },
  'プログラム名の入力欄' => {
    id: 'filename',
    selector: '#filename',
  },
  'セーブボタン' => {
    id: 'save-button',
    selector: '#save-button',
  },
}

step ':name にアクセスする' do |name|
  visit name_info[name][:path]
end

step ':name が表示されていること' do |name|
  expect(page).to have_selector(name_info[name][:selector])
end

step ':name 画面を表示する' do |name|
  visit name_info[name][:path]
end

step 'テキストエディタにプログラムを入力済みである:' do |source|
  page.execute_script("ace.edit('text-editor').getSession().getDocument().setValue('#{source}');")
end

step 'プログラムの名前に :filename を指定する' do |filename|
  fill_in('filename', with: filename)
end

step ':name をクリックする' do |name|
  click_button(name_info[name][:id])
end

step ':filename をダウンロードする' do |filename|
  expect(page.response_headers['Content-Disposition'])
    .to eq("attachment; filename=\"#{filename}\"")
  expect(page.response_headers['Content-Type'])
    .to eq('text/plain; charset=utf-8')
end

step 'ダウンロードしたファイルの内容が正しい:' do |source|
  # TODO
end

step 'ダウンロードしない' do
  # TODO
end

step ':name にフォーカスが移る' do |name|
  # 現在のPhantomJSでは$(':focus')は動作しない
  # https://github.com/netzpirat/guard-jasmine/issues/48
  js = "$('#filename').get(0) == document.activeElement"
  expect(page.evaluate_script(js)).to be_true
end

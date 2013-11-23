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
    'プログラム名の入力欄' => '#program-name',
    'セーブボタン' => '#save-button',
  }
  expect(page).to have_selector(name_selector[name])
end

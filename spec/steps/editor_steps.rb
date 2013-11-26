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

step ':text_editor にプログラムを入力済みである:' do |text_editor, source|
  page.execute_script(<<-JS)
    ace.edit('#{name_info[text_editor][:id]}')
      .getSession()
      .getDocument()
      .setValue('#{source}')
  JS
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
  expect(page.evaluate_script(<<-JS)).to be_true
    $('#filename').get(0) == document.activeElement
  JS
end

step ':filename をアップロードする' do |filename|
  page.execute_script("$('#load-file').show()")
  attach_file('load-file', Pathname(fixture_path).join(filename))
end

step ':text_editor に :filename を読み込む' do |text_editor, filename|
  expect(page.evaluate_script(<<-JS)).to eq(Pathname(fixture_path).join(filename).read)
    ace.edit('#{name_info[text_editor][:id]}')
      .getSession()
      .getDocument()
      .getValue()
  JS
end

step ':name に :value が入力される' do |name, value|
  expect(page.evaluate_script(<<-JS)).to eq(value)
    $('#{name_info[name][:selector]}').val()
  JS
end

step 'JavaScriptによるリクエストが終わるまで待つ' do
  start_time = Time.now
  page.evaluate_script('jQuery.isReady&&jQuery.active==0').class.should_not eql(String) until page.evaluate_script('jQuery.isReady&&jQuery.active==0') or (start_time + 5.seconds) < Time.now do
    sleep 1
  end
end

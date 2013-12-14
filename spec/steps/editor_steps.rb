# encoding: utf-8

step ':name にアクセスする' do |name|
  visit $name_info[name][:path]
end

step ':name が表示されていること' do |name|
  expect(page).to have_selector($name_info[name][:selector])
end

step ':name 画面を表示する' do |name|
  visit $name_info[name][:path]
end

step ':text_editor にプログラムを入力済みである:' do |text_editor, source|
  page.execute_script(<<-JS)
    ace.edit('#{$name_info[text_editor][:id]}')
      .getSession()
      .getDocument()
      .setValue('#{source}')
  JS
end

step ':text_editor のプログラムは以下である:' do |text_editor, source|
  expect(page.evaluate_script(<<-JS)).to eq(source)
    ace.edit('#{$name_info[text_editor][:id]}')
      .getSession()
      .getDocument()
      .getValue()
  JS
end

step 'プログラムの名前に :filename を指定する' do |filename|
  fill_in('filename', with: filename)
end

step ':name をクリックする' do |name|
  click_button($name_info[name][:id])
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

step ':name にフォーカスがあること' do |name|
  # HACK: 現在のPhantomJSでは$(':focus')は動作しない
  # https://github.com/netzpirat/guard-jasmine/issues/48
  expect(page.evaluate_script(<<-JS)).to be_true
    $('#{$name_info[name][:selector]}').get(0) == document.activeElement
  JS
end

step ':filename をロードする' do |filename|
  page.execute_script("$('#load-file').show()")
  attach_file('load-file', Pathname(fixture_path).join(filename))
end

step ':text_editor に :filename を読み込む' do |text_editor, filename|
  expect(page.evaluate_script(<<-JS)).to eq(Pathname(fixture_path).join(filename).read)
    ace.edit('#{$name_info[text_editor][:id]}')
      .getSession()
      .getDocument()
      .getValue()
  JS
end

step 'JavaScriptによるリクエストが終わるまで待つ' do
  start_time = Time.now
  page.evaluate_script('jQuery.isReady&&jQuery.active==0').class.should_not eql(String) until page.evaluate_script('jQuery.isReady&&jQuery.active==0') or (start_time + 5.seconds) < Time.now do
    sleep 1
  end
end

step ':text_editor のプログラムは :value である' do |text_editor, value|
  expect(page.evaluate_script(<<-JS)).to eq(value)
    ace.edit('#{$name_info[text_editor][:id]}')
      .getSession()
      .getDocument()
      .getValue()
  JS
end

step ':name は :value である' do |name, value|
  expect(page.evaluate_script(<<-JS)).to eq(value)
    $('#{$name_info[name][:selector]}').val()
  JS
end

step ':name に :message を含む' do |name, message|
  expect(page.find($name_info[name][:selector])).to have_content(message)
end

step 'ページをリロードする' do
end

step '警告ダイアログの :name ボタンをクリックする' do |name|
  case name
  when 'dismiss'
    if /selenium/ =~ Capybara.javascript_driver.to_s
      page.driver.browser.switch_to.alert.dismiss
    end
  else
    if /selenium/ =~ Capybara.javascript_driver.to_s
      page.driver.browser.switch_to.alert.accept
    end
  end
end

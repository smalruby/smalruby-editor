# encoding: utf-8

step ':name にアクセスする' do |name|
  visit NAME_INFO[name][:path]

  if poltergeist?
    page.execute_script(<<-JS)
      if (window.confirmMsg == undefined) {
        window.confirmMsg = null;
        window.confirm = function(msg) {
          window.confirmMsg = msg;
          return true;
        }
      }
    JS
  end
end

step ':name が表示されていること' do |name|
  expect(page).to have_selector(NAME_INFO[name][:selector])
end

step ':name 画面を表示する' do |name|
  send ':name にアクセスする', name
end

step 'プログラムの名前に :filename を指定する' do |filename|
  fill_in('filename', with: filename)
end

step ':name をクリックする' do |name|
  click_on(NAME_INFO[name][:id])
end

step 'ダウンロードが完了するまで待つ' do
  start_time = Time.now
  until page.response_headers['Content-Disposition'] ||
      (start_time + 5.seconds) < Time.now
    sleep 1
  end
end

step ':filename をダウンロードする' do |filename|
  step 'ダウンロードが完了するまで待つ'
  expect(page.response_headers['Content-Disposition'])
    .to eq("attachment; filename=\"#{filename}\"")
  expect(page.response_headers['Content-Type'])
    .to eq('text/plain; charset=utf-8')
end

step 'ダウンロードしない' do
  expect(page.response_headers['Content-Disposition']).to be_nil
end

step ':name にフォーカスがあること' do |name|
  # HACK: 現在のPhantomJSでは$(':focus')は動作しない
  # https://github.com/netzpirat/guard-jasmine/issues/48
  expect(page.evaluate_script(<<-JS)).to be_true
    $('#{NAME_INFO[name][:selector]}').get(0) == document.activeElement
  JS
end

step ':filename をロードする' do |filename|
  page.execute_script("$('#load-file').show()")
  attach_file('load-file', Pathname(fixture_path).join(filename))
end

step 'JavaScriptによるリクエストが終わるまで待つ' do
  start_time = Time.now
  until page.evaluate_script('jQuery.isReady && jQuery.active == 0') ||
      (start_time + 5.seconds) < Time.now
    sleep 1
  end
end
step ':name は :value である' do |name, value|
  expect(page.evaluate_script(<<-JS)).to eq(value)
    $('#{NAME_INFO[name][:selector]}').val()
  JS
end

step ':name に :message を含む' do |name, message|
  expect(page.find(NAME_INFO[name][:selector])).to have_content(message)
end

step ':name に :message を含まない' do |name, message|
  expect(page.find(NAME_INFO[name][:selector])).to have_no_content(message)
end

step 'ページをリロードする' do
end

step '警告ダイアログの :name ボタンをクリックする' do |name|
  case name
  when 'dismiss'
    page.driver.browser.switch_to.alert.dismiss if selenium?
  else
    page.driver.browser.switch_to.alert.accept if selenium?
  end
end

step '確認メッセージ :message を表示する' do |message|
  if poltergeist?
    actual = page.evaluate_script('window.confirmMsg')
    page.execute_script('window.confirmMsg = null')
    expect(actual).to eq(message)
  end
end

step '確認メッセージを表示しない' do
  if poltergeist?
    actual = page.evaluate_script('window.confirmMsg')
    page.execute_script('window.confirmMsg = null')
    expect(actual).to be_nil
  end
end

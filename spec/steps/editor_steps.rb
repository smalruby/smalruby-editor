# encoding: utf-8

step ':name にアクセスする' do |name|
  visit $name_info[name][:path]
  page.execute_script(<<-JS)
    if (window._open == undefined) {
      window.openUrl = null;
      window._open = window.open;
      window.open = function() {
        window.openUrl = arguments[0];
        if (arguments[1] != '_blank') {
          window._open.apply(window, arguments);
        }
      };
    }
  JS

  if poltergeist?
    page.execute_script(<<-JS)
      if (window.confirmMsg == undefined) {
        window.confirmMsg = null;
        window.confirm = function(msg) { window.confirmMsg = msg; return true; }
      }
    JS
  end
end

step ':name が表示されていること' do |name|
  expect(page).to have_selector($name_info[name][:selector])
end

step ':name 画面を表示する' do |name|
  send ':name にアクセスする', name
end

step 'プログラムの名前に :filename を指定する' do |filename|
  fill_in('filename', with: filename)
end

step ':name をクリックする' do |name|
  click_on($name_info[name][:id])
end

step ':filename をダウンロードする' do |filename|
  url = page.evaluate_script('window.openUrl')
  page.execute_script('window.openUrl = null')
  expect(URI.parse(url).query.split('&')).to include("filename=#{filename}")
end

step 'ダウンロードしない' do
  url = page.evaluate_script('window.openUrl')
  page.execute_script('window.openUrl = null')
  expect(url).to be_nil
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

step 'JavaScriptによるリクエストが終わるまで待つ' do
  start_time = Time.now
  page.evaluate_script('jQuery.isReady&&jQuery.active==0').class.should_not eql(String) until page.evaluate_script('jQuery.isReady&&jQuery.active==0') or (start_time + 5.seconds) < Time.now do
    sleep 1
  end
end
step ':name は :value である' do |name, value|
  expect(page.evaluate_script(<<-JS)).to eq(value)
    $('#{$name_info[name][:selector]}').val()
  JS
end

step ':name に :message を含む' do |name, message|
  expect(page.find($name_info[name][:selector])).to have_content(message)
end

step ':name に :message を含まない' do |name, message|
  expect(page.find($name_info[name][:selector])).to have_no_content(message)
end

step 'ページをリロードする' do
end

step '警告ダイアログの :name ボタンをクリックする' do |name|
  case name
  when 'dismiss'
    if selenium?
      page.driver.browser.switch_to.alert.dismiss
    end
  else
    if selenium?
      page.driver.browser.switch_to.alert.accept
    end
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

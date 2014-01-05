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
  if poltergeist?
    until page.response_headers['Content-Disposition'] ||
        (start_time + 5.seconds) < Time.now
      sleep(1)
    end
  elsif selenium?
    sleep(1) until downloads_dir.exist? || (start_time + 5.seconds) < Time.now
  end
end

step ':filename をダウンロードすること' do |filename|
  step 'ダウンロードが完了するまで待つ'
  if poltergeist?
    expect(page.response_headers['Content-Disposition'])
      .to eq("attachment; filename=\"#{filename}\"")
    expect(page.response_headers['Content-Type'])
      .to eq('text/plain; charset=utf-8')
  elsif selenium?
    expect(downloads_dir.join(filename)).to be_exist
  end
end

step 'ダウンロードしないこと' do
  if poltergeist?
    expect(page.response_headers['Content-Disposition']).to be_nil
  elsif selenium?
    expect(downloads_dir).not_to be_exist
  end
end

step ':name にフォーカスを移す' do |name|
  page.execute_script(<<-JS)
    $('#{NAME_INFO[name][:selector]}').focus()
  JS
end

step ':name にフォーカスがあること' do |name|
  # HACK: 現在のPhantomJSでは$(':focus')は動作しない
  # https://github.com/netzpirat/guard-jasmine/issues/48
  expect(page.evaluate_script(<<-JS)).to be_true
    $('#{NAME_INFO[name][:selector]}').get(0) == document.activeElement
  JS
end

step ':filename をロードする' do |filename|
  step '"ロードボタン" にフォーカスを移す'

  # HACK: input#load-file[type="file"]は非表示要素であるため、.show()し
  #   ないと見つけられずattach_fileが失敗する
  page.execute_script("$('#load-file').show()")

  path = Pathname(fixture_path).join(filename).to_s
  path.gsub!(File::SEPARATOR, File::ALT_SEPARATOR) if windows?
  attach_file('load-file', path)
end

step 'JavaScriptによるリクエストが終わるまで待つ' do
  start_time = Time.now
  until page.evaluate_script('jQuery.isReady && jQuery.active == 0') ||
      (start_time + 5.seconds) < Time.now
    sleep 1
  end
end
step ':name は :value であること' do |name, value|
  expect(page.evaluate_script(<<-JS)).to eq(value)
    $('#{NAME_INFO[name][:selector]}').val()
  JS
end

step ':name に :message を含むこと' do |name, message|
  expect(page.find(NAME_INFO[name][:selector])).to have_content(message)
end

step ':name に :message を含まないこと' do |name, message|
  expect(page.find(NAME_INFO[name][:selector])).to have_no_content(message)
end

step 'ページをリロードする' do
  begin
    step '"エディタ" 画面を表示する'
  rescue Capybara::Poltergeist::TimeoutError => e
    Rails.logger.debug("#{e.class.name}: #{e.message}")
  end
end

step '警告ダイアログの :name ボタンをクリックする' do |name|
  case name
  when 'dismiss'
    page.driver.browser.switch_to.alert.dismiss if selenium?
  else
    page.driver.browser.switch_to.alert.accept if selenium?
  end
end

step '確認メッセージ :message を表示すること' do |message|
  message.gsub!('\n', "\n")
  if poltergeist?
    actual = page.evaluate_script('window.confirmMsg')
    page.execute_script('window.confirmMsg = null')
    expect(actual).to eq(message)
  elsif selenium?
    expect(page.driver.browser.switch_to.alert.text).to eq(message)
    page.driver.browser.switch_to.alert.dismiss
  end
end

step '確認メッセージを表示しないこと' do
  if poltergeist?
    actual = page.evaluate_script('window.confirmMsg')
    page.execute_script('window.confirmMsg = null')
    expect(actual).to be_nil
  elsif selenium?
    expect {
      page.driver.browser.switch_to.alert
    }.to raise_exception(Selenium::WebDriver::Error::NoAlertPresentError)
  end
end

step '実際にはファイルをロードしないようにしておく' do
  if selenium?
    page.execute_script("$('#load-button').off('click')")
    page.execute_script(<<-JS)
      $('#load-button').click(function(e) {
        e.preventDefault();
        if (changed) {
          confirm('まだセーブしていないのでロードするとプログラムが消えてしまうよ！それでもロードしますか？');
        }
      })
    JS
  end
end

step 'ホームディレクトリに :program という内容の :filename が存在する' do |program, filename|
  File.open(Pathname("~/#{filename}").expand_path, 'w') do |f|
    f.write(program)
  end
end

step 'ホームディレクトリに :filename が存在すること' do |filename|
  path = Pathname("~/#{filename}").expand_path
  expect(path).to be_exist
end

step 'ホームディレクトリの :filename の内容が :program であること' do |filename, program|
  path = Pathname("~/#{filename}").expand_path
  expect(path.read).to eq(program)
end

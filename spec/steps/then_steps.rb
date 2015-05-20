# encoding: utf-8

step ':name が表示されていること' do |name|
  expect(page).to have_selector(name_to(name))
end

step ':name が表示されていないこと' do |name|
  expect(page).not_to have_selector(name_to(name))
end

step ':parent に :name が表示されていること' do |parent, name|
  within(name_to(parent)) do
    expect(page.all(name_to(name), visible: true)).not_to be_empty
  end
end

step ':parent に :name が表示されていないこと' do |parent, name|
  within(name_to(parent)) do
    expect(page.all(name_to(name), visible: true)).to be_empty
  end
end

step 'コンボボックス :name の :option_label を選択していること' do
  |name, option_label|
  expect(find(%{select[name="#{name}"] option[selected]}).text)
    .to eq(option_label)
end

step 'コンボボックス :name の :option_label を選択していないこと' do
  |name, option_label|
  expect(find(%{select[name="#{name}"] option[selected]}).text)
    .not_to eq(option_label)
end

step ':name がチェックされていること' do |name|
  expect(find(%{input[type="checkbox"][name="#{name}"]})).to be_checked
end

step ':name がチェックされていないこと' do |name|
  expect(find(%{input[type="checkbox"][name="#{name}"]})).not_to be_checked
end

step ':name にフォーカスがあること' do |name|
  # HACK: 現在のPhantomJSでは$(':focus')は動作しない
  # https://github.com/netzpirat/guard-jasmine/issues/48
  expect(page.evaluate_script(<<-JS)).to be_true
    $('#{name_to(name)}').get(0) == document.activeElement
  JS
end

step ':name は :value であること' do |name, value|
  expect(page.evaluate_script(<<-JS)).to eq(value)
    $('#{name_to(name)}').val()
  JS
end

step ':name フィールドの値が :value であること' do |name, value|
  expect(page).to have_field(name, with: value)
end

step ':name に :message を含むこと' do |name, message|
  expect(page.find(name_to(name))).to have_content(message)
end

step ':name に :message を含まないこと' do |name, message|
  expect(page.find(name_to(name))).not_to have_content(message)
end

step ':filename をダウンロードすること' do |filename|
  step 'ダウンロードが完了するまで待つ'
  if poltergeist?
    expect(page.response_headers['Content-Disposition'])
      .to match(/\Aattachment; filename="#{filename}"\z/)
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

step 'ホームディレクトリに :filename が存在すること' do |filename|
  path = Pathname("~/#{filename}").expand_path
  expect(path).to be_exist
end

step 'ホームディレクトリの :filename の内容が :program であること' do |filename, program|
  path = Pathname("~/#{filename}").expand_path
  expect(path.read).to eq(program)
end

step 'ホームディレクトリの :filename が次の内容であること:' do |filename, program|
  path = Pathname("~/#{filename}").expand_path
  expect(path.read).to eq(program)
end

step ':directory ディレクトリに :filename が存在すること' do
  |directory, filename|
  path = Pathname("#{directory}/#{filename}").expand_path
  expect(path).to be_exist
end

step ':directory ディレクトリの :filename の内容が :program であること' do
  |directory, filename, program|
  path = Pathname("#{directory}/#{filename}").expand_path
  expect(path.read).to eq(program)
end

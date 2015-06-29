# encoding: utf-8

step 'セッションをクリアする' do
  Capybara.reset_sessions!
end

step ':name にアクセスする' do |name|
  page.driver.headers = { 'Accept-Language' => 'ja' }
  visit name_to(name, :path)

  if poltergeist?
    page.execute_script('window.confirmResult = true')
    page.execute_script(<<-JS)
      if (window.confirmMsg == undefined) {
        window.confirmMsg = null;
        window.confirm = function(msg) {
          window.confirmMsg = msg;
          return window.confirmResult;
        }
      }
    JS
  end
end

step ':name 画面を表示する' do |name|
  send ':name にアクセスする', name
end

step ':name に :value を指定する' do |name, value|
  send(':name フィールドに :value を指定する', name, value)
end

step ':name フィールドに :value を指定する' do |name, value|
  fill_in(name_to(name, :id), with: value)
end

step ':name をチェックする' do |name|
  check(name)
end

step ':name のチェックを外す' do |name|
  uncheck(name)
end

step ':name にタブを切り替える' do |name|
  page.execute_script(<<-JS)
    $('#tabs a[href=\"#{name_to(name)}\"]').click()
  JS
end

step ':name タブを表示する' do |name|
  step '"エディタ" 画面を表示する'
  step %("#{name}タブ" にタブを切り替える)
end

step 'プログラムの名前に :filename を指定する' do |filename|
  step %("プログラム名の入力欄" に "#{filename}" を指定する)
end

step ':selector をクリックする' do |selector|
  # HACK: 以下では期待通りの動作にならなかったのでjQueryで無理やり実現した
  # click_on('submenu-button')
  # click_on(name_to(name, :id))
  page.execute_script("$('#{name_to(selector)}').click()")
end

step 'サブメニューの :selector をクリックする' do |selector|
  step %{"#{selector}" をクリックする}
  step %{JavaScriptによるリクエストが終わるまで待つ}
  step %{JavaScriptによるアニメーションが終わるまで待つ}
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

step ':name にフォーカスを移す' do |name|
  page.execute_script(<<-JS)
    $('#{name_to(name)}').focus()
  JS
end

step ':field フィールドにファイル :filename を設定する' do |field, filename|
  # HACK: input#load-file[type="file"]は非表示要素であるため、.show()し
  #   ないと見つけられずattach_fileが失敗する
  page.execute_script("$('##{field}').show()")

  path = Pathname(fixture_path).join(filename).to_s
  path.gsub!(File::SEPARATOR, File::ALT_SEPARATOR) if windows?
  attach_file(field, path)
end

step ':filename をロードする' do |filename|
  step '"ロードボタン" にフォーカスを移す'
  step %{'load-file' フィールドにファイル '#{filename}' を設定する}
end

step 'ページをリロードする' do
  begin
    if poltergeist?
      # HACK: Poltergeistではwindow.onbeforeunload によって表示されたダ
      #   イアログを消せないためタイムアウト時間を1秒にすることで回避し
      #   ている。
      page.driver.timeout = 2
      begin
        step '"エディタ" 画面を表示する'
      ensure
        page.driver.timeout = 120
      end
    else
      step '"エディタ" 画面を表示する'
    end
  rescue Capybara::Poltergeist::TimeoutError => e
    Rails.logger.debug("#{e.class.name}: #{e.message}")
  end
end

step 'JavaScriptによるリクエストが終わるまで待つ' do
  start_time = Time.now
  until page.evaluate_script('jQuery.isReady && jQuery.active == 0') ||
      (start_time + 5.seconds) < Time.now
    sleep 1
  end
end

step 'JavaScriptによるアニメーションが終わるまで待つ' do
  start_time = Time.now
  until page.evaluate_script('jQuery(":animated").length == 0') ||
      (start_time + 5.seconds) < Time.now
    sleep 1
  end
  sleep 1
end

step 'JavaScriptによる処理が終わるまで待つ' do
  step 'JavaScriptによるアニメーションが終わるまで待つ'
end

step '警告ダイアログの :name ボタンをクリックする' do |name|
  case name
  when 'dismiss'
    page.driver.browser.switch_to.alert.dismiss if selenium?
  else
    page.driver.browser.switch_to.alert.accept if selenium?
  end
end

step '確認ダイアログをキャンセルするようにしておく' do
  page.execute_script('window.confirmResult = false') if poltergeist?
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

step '実際にはファイルをダウンロードしないようにしておく' do
  if poltergeist?
    page.execute_script(<<-JS)
      $('#download-link').click(function(e) {
        e.preventDefault();
        return false;
      })
    JS
  end
end

step 'ホームディレクトリに :program という内容の :filename が存在する' do |program, filename|
  File.open(Pathname("~/#{filename}").expand_path, 'w') do |f|
    f.write(program)
  end
end

step ':directory ディレクトリに :program という内容の :filename が存在する' do
  |directory, program, filename|
  File.open(Pathname("#{directory}/#{filename}").expand_path, 'w') do |f|
    f.write(program)
  end
end

# rubocop:disable Eval
step '次のRubyのスクリプトを実行する:' do |script|
  eval(script)
end
# rubocop:enable Eval

step 'ページを表示する' do
  save_and_open_page
end

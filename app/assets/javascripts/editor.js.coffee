# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  textEditor = ace.edit('text-editor')
  textEditor.setTheme('ace/theme/clouds')
  textEditor.setShowInvisibles(true)

  session = textEditor.getSession()
  session.setMode('ace/mode/ruby')
  session.setTabSize(2)
  session.setUseSoftTabs(true)

  # FIXME: エディタの切り替え機能を実装するときに以下の処理を削除する。
  #   なお、navbarの中のリンクの見た目をよくするためにa要素を使っているのだが、
  #   デフォルトではRubyをクリックするとリンク先に遷移してしまう。そこでリンク
  #   をクリックしてもリンク先に遷移しないようにしている。
  $('ul.nav li a').click (e) ->
    e.preventDefault()
    false

  $('#save-button').click ->
    filename = $.trim($('#filename').val())
    if filename.length <= 0
      $('#filename').focus()
    else
      data =
        filename: filename
        source: session.getDocument().getValue()
      location.href = '/editor/save_file?' + $.param(data)

  $('#load-button').click ->
    $(@).parent().find('input[name="load_file"]').click()

  $('#filename').keypress (e) ->
    e = window.event if !e
    if e.keyCode == 13
      $('#save-button').click()
      false
    else
      true

  $('#file-form').fileupload(
    dataType: 'json'
    add: (e, data) ->
      data.submit()
    done: (e, data) ->
      file = data.result
      if file.error
        # エラーハンドリング
      else
        $('#filename').val(file.name)
        session.getDocument().setValue(file.source)
  )

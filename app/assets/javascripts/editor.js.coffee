# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  saving = false
  changed = false

  textEditor = ace.edit('text-editor')
  textEditor.setTheme('ace/theme/github')
  textEditor.setShowInvisibles(true)

  textEditor.focus()
  textEditor.gotoLine(0, 0)

  textEditor.on('change', (e) ->
    changed = true
  )

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

  $('#check-button').click (e) ->
    e.preventDefault()
    data =
      source_code:
        data: session.getDocument().getValue()
    success = (data, textStatus, jqXHR) ->
      for errorInfo in data
        do (errorInfo) ->
          msg = $('<div class="alert alert-error" style="display: none">')
            .append('<button type="button" class="close" data-dismiss="alert">×</button>')
            .append('<h4><i class="icon-exclamation-sign"></i>エラー</h4>')
            .append("#{errorInfo.row}行")
          if errorInfo.column > 0
            msg.append("、#{errorInfo.column}文字")
          msg.append(": #{errorInfo.message}")
          $('#messages').append(msg)
          msg.fadeIn('slow')
    $.post('/source_codes/check', data, success, 'json')

  $('#save-button').click (e) ->
    e.preventDefault()
    filename = $.trim($('#filename').val())
    if filename.length <= 0
      $('#filename').focus()
    else
      data =
        source_code:
          filename: filename
          data: session.getDocument().getValue()
      success = (data, textStatus, jqXHR) ->
        saving = true
        changed = false
        $('#download-link').click()
      $.post('/source_codes/', data, success, 'json')

  $('#load-button').click (e) ->
    e.preventDefault()
    if changed
      return unless confirm('まだセーブしていないのでロードするとプログラムが消えてしまうよ！それでもロードしますか？')
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
        msg = $('<div class="alert alert-error" style="display: none">')
          .append('<button type="button" class="close" data-dismiss="alert">×</button>')
          .append('<h4><i class="icon-exclamation-sign"></i>エラー</h4>')
          .append(file.name + 'は' + file.error)
        $('#messages').append(msg)
        msg.fadeIn('slow').delay(5000).fadeOut('slow')
      else
        $('#filename').val(file.name)
        session.getDocument().setValue(file.source)
        changed = false
  )

  window.onbeforeunload = (event) ->
    if !saving && session.getDocument().getValue().length > 0
      return '作成中のプログラムが消えてしまいます。'
    else
      saving = false
      return

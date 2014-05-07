# ナビゲーションメニューを表現するビュー
Smalruby.MainMenuView = Backbone.View.extend
  el: '#main-menu'

  events:
    'click #block-mode-button': 'onBlockMode'
    'click #ruby-mode-button': 'onRubyMode'
    'click #run-button': 'onRun'
    'click #download-button': 'onDownload'
    'click #load-local-button': 'onLoadLocal'
    'click #load-button': 'onLoad'
    'click #save-button': 'onSave'
    'click #check-button': 'onCheck'
    'click #reset-button': 'onReset'
    'click #signin-button': 'onSignin'
    'click #signout-button': 'onSignout'
    'click #username-button': 'onUsername'

  initialize: ->
    $('#filename').keypress (e) ->
      e = window.event if !e
      if e.keyCode == 13
        $('#save-button').click()
        false
      else
        true

    $('#file-form').fileupload
      dataType: 'json'
      done: (e, data) =>
        @load(data.result.source_code)

  onBlockMode: (e) ->
    e.preventDefault()

    return if window.blockMode

    unless Smalruby.changedAfterTranslating
      window.blockMode = true
      $('#tabs a[href="#block-tab"]').tab('show')
      return

    @blockUI
      title:
        """
        <i class="icon-filter"></i>
        プログラムの変換中
        """
      message: 'プログラムをブロックに変換しています。'

    sourceCode = new Smalruby.SourceCode()
    sourceCode.toBlocks()
      .then (data) ->
        window.blockMode = true
        $('#tabs a[href="#block-tab"]').tab('show')
        if data.length > 0
          Smalruby.blocklyLoading = true
          Smalruby.translating = true
          Smalruby.loadXml(data)
          Smalruby.translating = false
          Smalruby.changedAfterTranslating = false
      .then(@unblockUI, @unblockUI)
      .fail ->
        window.errorMessage('ブロックへの変換に失敗しました')

  onRubyMode: (e) ->
    e.preventDefault()

    return unless window.blockMode

    window.blockMode = false
    $('#tabs a[href="#ruby-tab"]').tab('show')

    return unless Smalruby.changedAfterTranslating

    data = Blockly.Ruby.workspaceToCode()
    Smalruby.translating = true
    window.textEditor.getSession().getDocument().setValue(data)
    Smalruby.translating = false
    Smalruby.changedAfterTranslating = false
    window.textEditor.moveCursorTo(0, 0)
    window.textEditor.focus()

  onRun: (e) ->
    e.preventDefault()

    sourceCode = @getSourceCode()

    filename = sourceCode.get('filename')
    filename += '.xml' unless filename.match(/\.xml$/)
    xmlSourceCode = new Smalruby.SourceCode({ filename: filename })

    clearMessages()

    @blockUI
      title:
        """
        <i class="icon-play"></i>
        プログラムの実行中
        """
      message: 'プログラムの画面に切り替えてください。'
      notice:
        """
        プログラムをセーブ・チェックしてから実行するよ♪<br>
        Escキーを押すとプログラムが終わります。
        """

    errorMsg = 'プログラムを実行できませんでした'
    sourceCode.save2()
      .then (data) ->
        sourceCode.write()
      .then (data) =>
        @confirmOverwrite_.call @, data, sourceCode, ->
          errorMsg = 'プログラムの実行をキャンセルしました'
      .then ->
        Smalruby.savedFilename = sourceCode.get('filename')
        window.changed = false
        sourceCode.check()
      .then (data) ->
        if data.length > 0
          for errorInfo in data
            do (errorInfo) ->
              msg = "#{errorInfo.row}行"
              if errorInfo.column > 0
                msg += "、#{errorInfo.column}文字"
              window.errorMessage(msg + ": #{errorInfo.message}")
          $.Deferred().reject().promise()
      .then ->
        xmlSourceCode.save2()
      .then ->
        xmlSourceCode.write(true)
      .then ->
        sourceCode.run()
      .then (data) ->
        if data.length > 0
          for errorInfo in data
            do (errorInfo) ->
              msg = "#{errorInfo.row}行"
              if errorInfo.column > 0
                msg += "、#{errorInfo.column}文字"
              errorMessage(msg + ": #{errorInfo.message}")
          $.Deferred().reject().promise()
      .then(@unblockUI, @unblockUI)
      .fail ->
        errorMessage(errorMsg)

  onDownload: (e) ->
    e.preventDefault()

    sourceCode = @getSourceCode()

    clearMessages()

    @blockUI
      title:
        """
        プログラムのダウンロード中
        """
      message: 'プログラムをダウンロードしています。'
      notice:
        """
        ダウンロードしたプログラムは、<br>
        Windowsだと「ruby #{sourceCode.get('filename')}」、<br>
        Macだと「rsdl #{sourceCode.get('filename')}」で実行できます。
        """

    sourceCode.save2()
      .then (data) ->
        window.changed = false
        window.successMessage('ダウンロードしました')
        Smalruby.downloading = true
        $('#download-link').click()
      .then(@unblockUI, @unblockUI)
      .fail ->
        window.errorMessage('ダウンロードできませんでした')

  onLoadLocal: (e) ->
    e.preventDefault()

    # TODO: window.changed -> Smalruby.Models.SourceCode.changed
    if window.changed
      return unless confirm('まだセーブしていないのでロードするとプログラムが消えてしまうよ！\nそれでもロードしますか？')

    Smalruby.Views.LoadModalView.render()

  onLoad: (e) ->
    e.preventDefault()

    # TODO: window.changed -> Smalruby.Models.SourceCode.changed
    if window.changed
      return unless confirm('まだセーブしていないのでロードするとプログラムが消えてしまうよ！\nそれでもロードしますか？')
    $('input#load-file[name="source_code[file]"]').click()

  onSave: (e) ->
    e.preventDefault()

    filename = $.trim($('#filename').val())
    if filename.length <= 0
      window.errorMessage('セーブする前にプログラムに名前をつけてね！')
      $('#filename').focus()
      return

    if window.blockMode
      filename += '.xml' unless filename.match(/\.xml$/)
      sourceCode = new Smalruby.SourceCode({ filename: filename })
    else
      sourceCode = @getSourceCode()

    clearMessages()

    @blockUI
      title:
        """
        プログラムのセーブ中
        """
      message: 'プログラムをセーブしています。'
      notice:
        """
        プログラムの名前は「#{sourceCode.get('filename')}」です。<br>
        プログラムはホームディレクトリにセーブします。<br>
        """

    errorMsg = 'セーブできませんでした'
    sourceCode.save2()
      .then (data) ->
        sourceCode.write()
      .then (data) =>
        @confirmOverwrite_.call @, data, sourceCode, ->
          errorMsg = 'セーブをキャンセルしました'
      .then(@unblockUI, @unblockUI)
      .done ->
        Smalruby.savedFilename = sourceCode.get('filename')
        window.changed = false
        window.successMessage('セーブしました')
      .fail ->
        window.errorMessage(errorMsg)

  onCheck: (e) ->
    e.preventDefault()

    clearMessages()

    sourceCode = @getSourceCode()

    @blockUI
      title:
        """
        プログラムのチェック中
        """
      message: 'プログラムの文法をチェックしています。'
      notice:
        """
        このチェックは簡易的なものですので、<br>
        プログラムを動かすとエラーが見つかるかもしれません。
        """

    sourceCode.check()
      .then (data) ->
        if data.length == 0
          window.successMessage('チェックしました', 'ただし、プログラムを動かすとエラーが見つかるかもしれません。')
        else
          for errorInfo in data
            do (errorInfo) ->
              msg = "#{errorInfo.row}行"
              if errorInfo.column > 0
                msg += "、#{errorInfo.column}文字"
              window.errorMessage(msg + ": #{errorInfo.message}")
      .then(@unblockUI, @unblockUI)
      .fail ->
        errorMessage('チェックできませんでした')

  onReset: (e) ->
    e.preventDefault()

    location.reload()

  onSignin: (e) ->
    e.preventDefault()

    Smalruby.Views.SigninModalView.render()

  onSignout: (e) ->
    e.preventDefault()

    $.ajax({
      url: '/signout'
      type: 'DELETE'
    })
      .then(
        (data) ->
          $('#signin-button').show()
          $('#signout-button').hide()
          $('#username-label').text('')
          $('#username-button').hide()
          successMessage('ログアウトしました')
        ->
          errorMessage('ログアウトに失敗しました')
      )

  onUsername: (e) ->
    e.preventDefault()

  getFilename: ->
    $.trim($('#filename').val())

  getSourceCode: ->
    sourceCode = new Smalruby.SourceCode()
    $('#filename').val(sourceCode.get('filename'))
    sourceCode

  blockUI: (options) ->
    message = ''
    if options.title
      message +=
        """
        <h3>
          #{options.title}
        </h3>
        """

    if options.message || options.notice
      part = ''
      if options.message
        part +=
          """
          <p>
            #{options.message}
          </p>
          """
      if options.notice
        part +=
          """
          <small>
            #{options.notice}
          </small>
          """

      message +=
        """
        <blockquote>
          #{part}
        </blockquote>
        """

    $.blockUI
      message: message
      css:
        border: 'none'
        'text-align': 'left'
        'padding-left': '2em'

  unblockUI: ->
    $.unblockUI()

  confirmOverwrite_: (data, sourceCode, canceled = $.noop) ->
    if data.source_code.error
      if sourceCode.get('filename') == Smalruby.savedFilename ||
         confirm("前に#{sourceCode.get('filename')}という名前でセーブしているけど本当にセーブしますか？\nセーブすると前に作成したプログラムは消えてしまうよ！")
        sourceCode.write(true)
      else
        canceled.call()
        $.Deferred().reject().promise()

  load: (info) ->
    if info.error
      window.errorMessage(info.filename + 'は' + info.error)
    else
      clearMessages()

      filename = info.filename
      if filename.match(/\.xml$/)
        unless window.blockMode
          window.blockMode = true
          $('#tabs a[href="#block-tab"]').tab('show')

        filename = filename.replace(/(\.rb)?\.xml$/, '.rb')
        Smalruby.blocklyLoading = true
        Smalruby.loadXml(info.data)
        info.data = Blockly.Ruby.workspaceToCode()
      else
        Smalruby.Collections.CharacterSet.reset()
        Blockly.mainWorkspace.clear()

        if window.blockMode
          window.blockMode = false
          $('#tabs a[href="#ruby-tab"]').tab('show')
          window.textEditor.focus()

      $('#filename').val(filename)
      window.textEditor.getSession().getDocument().setValue(info.data)
      window.textEditor.moveCursorTo(0, 0)
      # TODO: window.changed -> Smalruby.Models.SourceCode.changed
      window.changed = false
      Smalruby.changedAfterTranslating = true
      window.successMessage('ロードしました')

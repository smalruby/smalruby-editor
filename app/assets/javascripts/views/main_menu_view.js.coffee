# ナビゲーションメニューを表現するビュー
Smalruby.MainMenuView = Backbone.View.extend
  el: '#main-menu'

  events:
    'click #run-button': 'onRun'
    'click #download-button': 'onDownload'
    'click #load-button': 'onLoad'
    'click #save-button': 'onSave'
    'click #check-button': 'onCheck'
    'click #reset-button': 'onReset'

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
      done: (e, data) ->
        info = data.result.source_code
        if info.error
          window.errorMessage(info.filename + 'は' + info.error)
        else
          filename = info.filename
          if filename.match(/\.xml$/)
            unless window.blockMode
              $('#tabs a[href="#block-tab"]').tab('show')

            filename = filename.replace(/(\.rb)?\.xml$/, '.rb')
            Smalruby.blocklyLoading = true
            Smalruby.loadXml(info.data)
            info.data = Blockly.Ruby.workspaceToCode()
          else
            Smalruby.Collections.CharacterSet.reset()
            Blockly.mainWorkspace.clear()

            if window.blockMode
              $('#tabs a[href="#ruby-tab"]').tab('show')
              window.textEditor.focus()

          $('#filename').val(filename)
          window.textEditor.getSession().getDocument().setValue(info.data)
          window.textEditor.moveCursorTo(0, 0)
          # TODO: window.changed -> Smalruby.Models.SourceCode.changed
          window.changed = false
          window.successMessage('ロードしました')

  onRun: (e) ->
    e.preventDefault()

    sourceCode = @getSourceCode()

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

    failedFunc = ->
      $.unblockUI()
      errorMessage('プログラムを実行できませんでした')

    sourceCode.save2()
      .done (data) ->
        sourceCode.write()
          .done (data) ->
            afterSave = ->
              Smalruby.savedFilename = sourceCode.get('filename')
              window.changed = false
              sourceCode.check()
                .done (data) ->
                  if data.length > 0
                    failedFunc()
                    for errorInfo in data
                      do (errorInfo) ->
                        msg = "#{errorInfo.row}行"
                        if errorInfo.column > 0
                          msg += "、#{errorInfo.column}文字"
                        window.errorMessage(msg + ": #{errorInfo.message}")
                  else
                    sourceCode.run()
                      .done (data) ->
                        $.unblockUI()
                        if data.length > 0
                          for errorInfo in data
                            do (errorInfo) ->
                              msg = "#{errorInfo.row}行"
                              if errorInfo.column > 0
                                msg += "、#{errorInfo.column}文字"
                              errorMessage(msg + ": #{errorInfo.message}")

                      .fail -> failedFunc()

                .fail -> failedFunc()

            if data.source_code.error
              if sourceCode.get('filename') == Smalruby.savedFilename ||
                 confirm("前に#{sourceCode.get('filename')}という名前でセーブしているけど本当にセーブしますか？\nセーブすると前に作成したプログラムは消えてしまうよ！")
                sourceCode.write(true)
                  .done (data) ->
                    afterSave()
              else
                failedFunc()
            else
              afterSave()
          .fail -> failedFunc()
      .fail -> failedFunc()

  onDownload: (e) ->
    e.preventDefault()

    sourceCode = @getSourceCode()

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
      .done (data) ->
        $.unblockUI()
        window.changed = false
        window.successMessage('ダウンロードしました')
        Smalruby.downloading = true
        $('#download-link').click()
      .fail ->
        $.unblockUI()
        window.errorMessage('ダウンロードできませんでした')

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

    sourceCode = @getSourceCode()

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

    failedFunc = ->
      $.unblockUI()
      window.errorMessage('セーブできませんでした')

    sourceCode.save2()
      .done (data) ->
        sourceCode.write()
          .done (data) ->
            afterSave = ->
              $.unblockUI()
              Smalruby.savedFilename = sourceCode.get('filename')
              window.changed = false
              window.successMessage('セーブしました')

            if data.source_code.error
              if sourceCode.get('filename') == Smalruby.savedFilename ||
                 confirm("前に#{sourceCode.get('filename')}という名前でセーブしているけど本当にセーブしますか？\nセーブすると前に作成したプログラムは消えてしまうよ！")
                sourceCode.write(true)
                  .done (data) ->
                    afterSave()
              else
                $.unblockUI()
                window.successMessage('セーブをキャンセルしました')
            else
              afterSave()
          .fail -> failedFunc()
      .fail -> failedFunc()

  onCheck: (e) ->
    e.preventDefault()

    # TODO: 既存のシンタックスに関するエラーメッセージをcloseしておく

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
      .done (data) ->
        $.unblockUI()
        if data.length == 0
          window.successMessage('チェックしました', 'ただし、プログラムを動かすとエラーが見つかるかもしれません。')
        else
          for errorInfo in data
            do (errorInfo) ->
              msg = "#{errorInfo.row}行"
              if errorInfo.column > 0
                msg += "、#{errorInfo.column}文字"
              window.errorMessage(msg + ": #{errorInfo.message}")
      .fail ->
        $.unblockUI()
        errorMessage('チェックできませんでした')

  onReset: (e) ->
    e.preventDefault()

    location.reload()

  getFilename: ->
    $.trim($('#filename').val())

  getSourceCode: ->
    sourceCode = new Smalruby.SourceCode()
    $('#filename').val(sourceCode.get('filename'))
    sourceCode

  blockUI: (options) ->
    $.blockUI
      message:
        """
        <h3>
          #{options.title}
        </h3>
        <blockquote>
          <p>
            #{options.message}
          </p>
          <small>
            #{options.notice}
          </small>
        </blockquote>
        """
      css:
        border: 'none'
        'text-align': 'left'
        'padding-left': '2em'

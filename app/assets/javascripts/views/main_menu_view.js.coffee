# ナビゲーションメニューを表現するビュー
Smalruby.MainMenuView = Backbone.View.extend
  el: '#main-menu'

  events:
    'click button#run-button': 'onRun'
    'click a#reset-button': 'onReset'

  onRun: (e) ->
    e.preventDefault()

    sourceCode = new Smalruby.SourceCode()
    $('#filename').val(sourceCode.get('filename'))

    $.blockUI
      message:
        """
        <h3>
          <i class="icon-play"></i>
          プログラムの実行中
        </h3>
        <blockquote>
          <p>
            プログラムの画面に切り替えてください。
          </p>
          <small>
            Escキーを押すとプログラムが終わります。<br>
            続きはプログラムが終わってからです♪
          </small>
        </blockquote>
        """
      css:
        border: 'none'

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
      .fail ->
        $.unblockUI()
        errorMessage('実行できませんでした')

  onReset: (e) ->
    e.preventDefault()

    location.reload()

  getFilename: ->
    $.trim($('#filename').val())

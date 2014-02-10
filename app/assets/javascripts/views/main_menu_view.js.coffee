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
    sourceCode.run()
      .done (data) ->
        if data.length == 0
          successMessage('実行しました')
        else
          for errorInfo in data
            do (errorInfo) ->
              msg = "#{errorInfo.row}行"
              if errorInfo.column > 0
                msg += "、#{errorInfo.column}文字"
              errorMessage(msg + ": #{errorInfo.message}")
      .fail ->
        errorMessage('実行できませんでした')

  onReset: (e) ->
    e.preventDefault()

    location.reload()

  getFilename: ->
    $.trim($('#filename').val())

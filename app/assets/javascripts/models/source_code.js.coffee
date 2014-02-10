# ソースコードを表現するモデル
Smalruby.SourceCode = Backbone.Model.extend
  defaults:
    filename: null
    data: null

  initialize: ->
    unless @get('filename')
      filename = Smalruby.Views.MainMenuView.getFilename()
      if filename.length == 0
        c = Smalruby.Collections.CharacterSet.first()
        if c
          filename = "#{c.get('name')}.rb"
        else
          filename = '1.rb'
      @set('filename', filename)

    if @get('filename').match(/\.xml$/)
      data = Smalruby.dumpXml()
    else
      if window.blockMode
        data = Blockly.Ruby.workspaceToCode()
      else
        data =window.textEditor.getSession().getDocument().getValue()

    @set('data', data)

  run: ->
    dfr = $.Deferred()
    $.ajax
      url: '/source_codes/run'
      type: 'POST'
      data:
        source_code:
          filename: @get('filename')
          data: @get('data')
      dataType: 'json'
      success: (data, textStatus, jqXHR) -> dfr.resolve(data)
      error: dfr.reject
    dfr.promise()

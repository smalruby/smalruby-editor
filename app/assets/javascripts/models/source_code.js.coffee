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

    unless @get('data')
      if @get('filename').match(/\.xml$/)
        data = Smalruby.dumpXml()
      else
        if window.blockMode
          data = Blockly.Ruby.workspaceToCode()
        else
          data = window.textEditor.getSession().getDocument().getValue()

      @set('data', data)

  getRbxmlFilename: ->
    filename = @get('filename')
    if filename.match(/\.rb\.xml$/)
      filename
    else
      if filename.match(/\.rb$/)
        filename + '.xml'
      else if filename.match(/\.xml$/)
        filename.replace(/\.xml$/, '.rb.xml')
      else
        filename + '.rb.xml'

  run: ->
    @post_('run')

  check: ->
    @post_('check')

  save2: ->
    @post_('')

  write: (force = false) ->
    action = 'write'
    action += '?force=1' if force
    @delete_(action)

  toBlocks: ->
    @post_('to_blocks', 'html')

  post_: (action, dataType = 'json') ->
    dfr = $.Deferred()
    $.ajax
      url: "/source_codes/#{action}"
      type: 'POST'
      data:
        source_code:
          filename: @get('filename')
          data: @get('data')
      dataType: dataType
      success: (data, textStatus, jqXHR) -> dfr.resolve(data)
      error: dfr.reject
    dfr.promise()

  delete_: (action) ->
    dfr = $.Deferred()
    $.ajax
      url: "/source_codes/#{action}"
      type: 'DELETE'
      dataType: 'json'
      success: (data, textStatus, jqXHR) -> dfr.resolve(data)
      error: dfr.reject
    dfr.promise()

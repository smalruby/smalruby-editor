# キャラクター選択を表現するビュー
Smalruby.CharacterSelectorView = Backbone.View.extend({
  el: '#character-selector-tab'

  initialize: ->
    @klass = Smalruby.CharacterSelectorView

    @listenTo(@model, name, @onChange) for name in ['add', 'remove', 'reset', 'change']

    @templateText = $('#character-selector-template').text()

    $('#add-character-button').click (e) ->
      e.preventDefault()

      charSet = Smalruby.Collections.CharacterSet
      attrs =
        if (last = _.last(charSet.models))
          name: charSet.uniqueName(last.costume())
          costumes: _.clone(last.get('costumes'))
        else
          name: charSet.uniqueName()
      c = new Smalruby.Character(attrs)
      charSet.add(c)

      Smalruby.Views.CharacterModalView.setCharacter(c).render()

    @render()

  render: ->
    charsEl = $('#character-selector-character-set')
    charsEl.children().remove()

    @model.each (character) =>
      html = $(_.template(@templateText, character))
      charsEl.append(html)

      html.find('a.character').click (e) ->
        e.preventDefault()
        Smalruby.Views.CharacterModalView.setCharacter(character).render()

      html.find('a.add-block-button').click (e) =>
        e.preventDefault()
        @addBlock_(character)

      removeButton = html.find('a.remove-button')
      removeButton.click (e) =>
        e.preventDefault()
        @removeCharacter_(character)
      if character.get('using')
        removeButton.hide()

      img = html.find('img')
      character.rotateImage(img)
      img.on 'dragstart', (e) ->
        e.preventDefault()

  onChange: ->
    unless Smalruby.blocklyLoading
      Smalruby.changedAfterTranslating = true
      window.changed = true
    @render()

  addBlock_: (character) ->
    newBlock = Blockly.Block.obtain(Blockly.mainWorkspace, 'character_new')
    newBlock.setCharacter(character)
    newBlock.initSvg()
    newBlock.render()
    @moveByNewBlock_(newBlock)
    newBlock.select()

    onStartBlock = Blockly.Block.obtain(Blockly.mainWorkspace, 'events_on_start')
    onStartBlock.initSvg()
    onStartBlock.render()
    newBlock.getInput('DO').connection.connect(onStartBlock.previousConnection)

  moveByNewBlock_: (newBlock) ->
    metrics = Blockly.mainWorkspace.getMetrics()
    newXY =
      x: metrics.viewLeft + @klass.NEW_BLOCK_MARGIN.LEFT
      y: metrics.viewTop + @klass.NEW_BLOCK_MARGIN.TOP

    if @prevBlock
      xy = @prevBlock.getRelativeToSurfaceXY()
      hw = @prevBlock.getHeightWidth()
      newHW = newBlock.getHeightWidth()
      if xy.x == @prevXY.x && xy.y == @prevXY.y
        x = xy.x
        y = xy.y + hw.height + @klass.NEW_BLOCK_MARGIN.TOP
        if y + newHW.height > metrics.viewTop + metrics.viewHeight
          x += hw.width + @klass.NEW_BLOCK_MARGIN.LEFT
          y = newXY.y
      else
        x = @prevXY.x
        y = @prevXY.y
      if x >= metrics.viewLeft &&
         x + newHW.width <= metrics.viewLeft + metrics.viewWidth &&
         y >= metrics.viewTop &&
         y + newHW.height <= metrics.viewTop + metrics.viewHeight
        newXY.x = x
        newXY.y = y

    newBlock.moveBy(newXY.x, newXY.y)

    @prevBlock = newBlock
    @prevXY = newBlock.getRelativeToSurfaceXY()

  removeCharacter_: (character) ->
    unless character.get('using')
      Smalruby.Collections.CharacterSet.remove(character)

}, {
  NEW_BLOCK_MARGIN:
    LEFT: 20
    TOP: 20
})

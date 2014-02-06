# キャラクター選択を表現するビュー
Smalruby.CharacterSelectorView = Backbone.View.extend({
  el: '#character-selector-tab'

  initialize: ->
    @listenTo(@model, name, @render) for name in ['add', 'remove', 'reset', 'change']

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

    @new_block_position = _.clone(Smalruby.CharacterSelectorView.NEW_BLOCK_POSITION)
    @prev_block = null

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

      addBlockButton = html.find('a.add-block-button')
      addBlockButton.click (e) =>
        e.preventDefault()

        if @prev_block
          xy = @prev_block.getRelativeToSurfaceXY()
          console.log(xy)
          console.log(@new_block_position)

        block = new Blockly.Block(Blockly.mainWorkspace, 'character_new')
        block.setCharacter(character)
        block.initSvg()
        block.render()
        block.moveBy(@new_block_position.x, @new_block_position.y)
        block.select()

        @prev_block = block
        klass = Smalruby.CharacterSelectorView
        @new_block_position.x += klass.NEW_BLOCK_DISTANCE
        if @new_block_position.x > klass.NEW_BLOCK_MAX_POSITION.x
          @new_block_position.x = klass.NEW_BLOCK_POSITION.x
        @new_block_position.y += klass.NEW_BLOCK_DISTANCE
        if @new_block_position.y > klass.NEW_BLOCK_MAX_POSITION.y
          @new_block_position.y = klass.NEW_BLOCK_POSITION.y

        character.set('using', true)

      removeButton = html.find('a.remove-button')
      removeButton.click (e) ->
        e.preventDefault()
        unless character.get('using')
          Smalruby.Collections.CharacterSet.remove(character)
      if character.get('using')
        removeButton.hide()

      rotate = "rotate(#{character.get('angle') * -1}deg)"
      html.find('img').css
        '-moz-transform': rotate
        '-webkit-transform': rotate
        transform: rotate
}, {
  NEW_BLOCK_POSITION:
    x: 0
    y: 0

  NEW_BLOCK_DISTANCE: 20

  NEW_BLOCK_MAX_POSITION:
    x: 320
    y: 240
})

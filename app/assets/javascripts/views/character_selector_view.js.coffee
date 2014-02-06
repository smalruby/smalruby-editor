# キャラクター選択を表現するビュー
Smalruby.CharacterSelectorView = Backbone.View.extend
  el: '#character-selector-tab'

  initialize: ->
    @listenTo(@model, name, @render) for name in ['add', 'remove', 'reset', 'change']

    @templateText = $('#character-selector-template').text()

    @render()

  render: ->
    @$el.children().remove()

    @model.each (character) =>
      html = $(_.template(@templateText, character))
      @$el.append(html)

      html.find('a.character').click (e) ->
        e.preventDefault()
        Smalruby.Views.CharacterModalView.setCharacter(character).render()

      addBlockButton = html.find('a.add-block-button')
      addBlockButton.click (e) ->
        e.preventDefault()
        # TODO: キャラクターブロックの追加処理を実装する

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

    html = $('<div class="item"><a class="character"><i class="icon-plus-sign"></a></div>')
    @$el.append(html)

    html.find('a').click (e) ->
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

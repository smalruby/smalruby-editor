# キャラクター選択を表現するビュー
Smalruby.CharacterSelectorView = Backbone.View.extend
  el: '#character-selector-tab'

  initialize: ->
    @.listenTo(@.model, name, @.render) for name in ['add', 'remove', 'reset', 'change']

    @.templateText = $('#character-selector-template').text()

    @.render()

  render: ->
    @.$el.children().remove()

    self = @
    @.model.each (character) ->
      html = $(_.template(self.templateText, character))
      self.$el.append(html)

      html.find('a.character').click (e) ->
        e.preventDefault()
        Smalruby.Views.CharacterModalView.setCharacter(character).render()

      removeButton = html.find('a.remove-button')
      removeButton.click (e) ->
        e.preventDefault()
        unless character.get('using')
          Smalruby.Collections.CharacterSet.remove(character)
      if character.get('using')
        removeButton.hide()

    html = $('<div class="item"><a class="character"><i class="icon-plus-sign"></a></div>')
    @.$el.append(html)

    html.find('a').click (e) ->
      e.preventDefault()
      character = new Smalruby.Character()
      Smalruby.Collections.CharacterSet.add(character)
      Smalruby.Views.CharacterModalView.setCharacter(character).render()

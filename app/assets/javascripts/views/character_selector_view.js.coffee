# キャラクター選択を表現するビュー
Smalruby.CharacterSelectorView = Backbone.View.extend
  el: '#character-selector-tab'

  initialize: ->
    @.listenTo(@.model, name, @.render) for name in ['add', 'remove', 'reset', 'change']

    @.templateText = $('#character-selector-template').text()

    @.render()

  render: ->
    self = @
    @.$el.children().remove()
    @.model.each (character) ->
      html = $(_.template(self.templateText, character))
      self.$el.append(html)
      html.find('a').click (e) ->
        e.preventDefault()
        Smalruby.Views.CharacterModalView.setCharacter(character).render()

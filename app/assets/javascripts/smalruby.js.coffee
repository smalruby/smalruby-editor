window.Smalruby =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    @.Views.CharacterModalView = new Smalruby.CharacterModalView({ el: $('#character-modal') })

$(document).ready ->
  Smalruby.initialize()

window.Smalruby =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    # HACK: Underscoreのテンプレートの<%, %>はHamlと組み合わせたときに
    #   HTML要素の属性がHamlによってエスケープされてしまうため使いにく
    #   い。そこで、それぞれ{{, }}に変更する。
    _.extend(_.templateSettings, {
      escape: /{{-([\s\S]+?)}}/
      evaluate: /{{([\s\S]+?)}}/
      interpolate: /{{=([\s\S]+?)}}/
    })

    @.Collections.CharacterSet = new Smalruby.CharacterSet()

    @.Views.CharacterSelectorView = new Smalruby.CharacterSelectorView
      model: @.Collections.CharacterSet
    @.Views.CharacterModalView = new Smalruby.CharacterModalView
      el: $('#character-modal')

$(document).ready ->
  Smalruby.initialize()

# キャラクターの一覧を表現するコレクション
Smalruby.CharacterSet = Backbone.Collection.extend
  model: Smalruby.Character

  uniqueName: (costume = Smalruby.Character.PRESET_COSTUMES[0])->
    prefix = costume.substring(costume.lastIndexOf('/') + 1).replace(/\.[^.]*$/, '').replace(/[\d]*$/, '')
    max = 0
    r = new RegExp('^' + prefix + '(\\d+)$')
    _.each @pluck('name'), (name) ->
      if name.match(r)
        max = _.max([max, parseInt(RegExp.$1)])
    "#{prefix}#{max + 1}"

Smalruby.Character = Backbone.Model.extend({
  defaults:
    name: null
    costumes: [],
    costumeIndex: 0
    x: 0
    y: 0
    angle: 0
    visible: true
    using: false

  initialize: ->
    if @get('costumes').length == 0
      @set({ costumes: [Smalruby.Character.PRESET_COSTUMES[0]] })

  namePrefix: ->
    Smalruby.Character.costumeToNamePrefix(@get('name'))

  costume: ->
    @get('costumes')[@get('costumeIndex')]

  costumeUrl: (index = @get('costumeIndex')) ->
    basename = @get('costumes')[index]
    if _.indexOf(Smalruby.Character.PRESET_COSTUMES, basename) == -1
      basename
    else
      "/smalruby/assets/#{basename}"

  nextCostume: ->
    i = @get('costumeIndex') + 1
    i = 0 if i >= @get('costumes').length
    @set({ 'costumeIndex': i })
    i
}, {
  PRESET_COSTUMES: [
    'car1.png'
    'car2.png'
    'car3.png'
    'car4.png'
    'ball1.png'
    'ball2.png'
    'ball3.png'
    'ball4.png'
    'ball5.png'
    'ball6.png'
    'cat1.png'
    'cat2.png'
    'cat3.png'
    'frog1.png'
  ]

  costumeToNamePrefix: (costume) ->
    costume.substring(costume.lastIndexOf('/') + 1).replace(/\.[^.]*$/, '').replace(/[\d]*$/, '')
})

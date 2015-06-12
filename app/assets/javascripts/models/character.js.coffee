Smalruby.Character = Backbone.Model.extend({
  defaults:
    name: null
    costumes: [],
    costumeNames: [],
    costumeIndex: 0
    x: 0
    y: 0
    angle: 0
    rotationStyle: 'free'
    visible: true
    using: false

  initialize: ->
    @objects = []
    if @get('costumes').length == 0
      @set({ costumes: [Smalruby.Character.PRESET_COSTUMES[0]] })
    else
      costumes = []
      costumeNames = []
      index = 1
      for costume in (costume.split(':') for costume in @get('costumes'))
        do (costume) ->
          if costume.length == 1
            costumeNames.push("costume#{index}")
            costumes.push(costume[0])
          else
            costumeNames.push(costume[0])
            costumes.push(costume[1])
          index++
      @set({ costumes: costumes, costumeNames: costumeNames })

    if @get('costumeNames').length == 0
      @set({ costumeNames: ['costume1'] })

  validate: (attrs, options) ->
    errors = []

    name = attrs.name
    if _.isUndefined(name) || _.isNull(name) ||
       (_.isString(name) && name.length == 0)
      errors.push
        attr: 'name'
        message: 'Name is required'

    if _.isString(name) &&
       name.match(/^[0-9A-Z]|[!\"\#$%&\'()\-=^~\\|@`\[{;+:*\]},<.>/?]/)
      errors.push
        attr: 'name'
        message: 'Name is invalid'

    i = 0
    costumeNames = attrs.costumeNames
    for name in costumeNames
      do (name) ->
        if _.isUndefined(name) || _.isNull(name) ||
           (_.isString(name) && name.length == 0)
          errors.push
            attr: 'costumeNames'
            index: i
            message: 'costumeNames is required'
        else if _.indexOf(costumeNames, name) != _.lastIndexOf(costumeNames, name)
          errors.push
            attr: 'costumeNames'
            index: i
            message: 'costumeNames is duplicated'
        i++

    if errors.length > 0
      return errors

    return

  link: (object) ->
    @objects.push(object)
    @objects = _.uniq(@objects)
    if @objects.length > 0
      @set('using', true)

  unlink: (object) ->
    @objects = _.without(@objects, object)
    if @objects.length == 0
      @set('using', false)

  namePrefix: ->
    Smalruby.Character.costumeToNamePrefix(@get('name'))

  costume: (index = @get('costumeIndex')) ->
    @get('costumes')[index]

  costumeName: (index = @get('costumeIndex')) ->
    @get('costumeNames')[index]

  costumesWithName: ->
    costumeNames = @get('costumeNames')
    ("#{costumeNames[i]}:#{costume}" for costume, i in @get('costumes'))

  costumeUrl: (index = @get('costumeIndex')) ->
    basename = @get('costumes')[index]
    "/smalruby/assets/#{basename}"

  nextCostume: ->
    i = @get('costumeIndex') + 1
    i = 0 if i >= @get('costumes').length
    @set({ 'costumeIndex': i })
    i

  rotationStyleIconName: ->
    switch @get('rotationStyle')
      when 'free'
        'icon-repeat'
      when 'left_right'
        'icon-resize-horizontal'
      when 'none'
        'icon-arrow-right'

  rotateImage: (selector) ->
    angle = @get('angle')
    switch @get('rotationStyle')
      when 'free'
        transformValue = "rotate(#{angle}deg) scaleX(1)"
      when 'left_right'
        if angle < 90 || angle >= 270
          transformValue = "rotate(0deg) scaleX(1)"
        else
          transformValue = "rotate(0deg) scaleX(-1)"
      when 'none'
        transformValue = "rotate(0deg) scaleX(1)"
    $(selector).css
      '-moz-transform': transformValue
      '-webkit-transform': transformValue
      transform: transformValue
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
    'ryu1.png'
    'ryu2.png'
    'taichi1.png'
    'taichi2.png'
  ]

  costumeToNamePrefix: (costume) ->
    costume.substring(costume.lastIndexOf('/') + 1).replace(/\.[^.]*$/, '').replace(/[\d]*$/, '')
})

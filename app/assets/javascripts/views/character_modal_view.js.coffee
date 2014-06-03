# キャラクター設定ダイアログを表現するビュー
Smalruby.CharacterModalView = Backbone.View.extend
  model: new Smalruby.Character()

  events:
    'click #character-modal-costume-selector a': 'onSelectCostume'
    'click #character_rotation_style_free': 'onRotationStyleFree'
    'click #character_rotation_style_left_right': 'onRotationStyleLeftRight'
    'click #character_rotation_style_none': 'onRotationStyleNone'
    'click #character-modal-ok-button': 'onOk'

  previewZoomLevel: 0.5

  initialize: ->
    @target = null

    $('#character-modal-costume-selector img').on 'dragstart', (e) ->
      e.preventDefault()

    setPosition = (pos) =>
      @model.set
        x: parseInt(pos.left / @previewZoomLevel)
        y: parseInt(pos.top / @previewZoomLevel)

    $('#character-modal-character').draggable
      containment: '#character-modal-preview'
      cursor: 'move'
      drag: (event, ui) ->
        setPosition(ui.position)

    $('#character-modal-preview').droppable
      drop: (event, ui) ->
        setPosition(ui.draggable.position())

    @$el.find('input[name="character[name]"]').keypress (e) ->
      e = window.event if !e
      if e.keyCode == 13
        false
      else
        true

    self = @
    changeNameFunc = (e) ->
      self.model.set({ name: $(@).val() })
      self.nameChanged = true
    @$el.find('input[name="character[name]"]').change(changeNameFunc)
    @$el.find('input[name="character[name]"]').keyup(changeNameFunc)

    @$el.find('input[name="character[x]"]').change (e) ->
      self.model.set({ x: $(@).val() })

    @$el.find('input[name="character[y]"]').change (e) ->
      self.model.set({ y: $(@).val() })

    @$el.find('input[name="character[angle]"]').change (e) ->
      self.model.set({ angle: $(@).val() })

    @listenTo(@model, 'change:name', @onChangeName)
    @listenTo(@model, 'change:x', @onChangeX)
    @listenTo(@model, 'change:y', @onChangeY)
    @listenTo(@model, 'change:angle', @onChangeAngle)
    @listenTo(@model, 'change:costumes', @onChangeCostumes)
    @listenTo(@model, 'change:rotationStyle', @onChangeRotationStyle)
    @listenTo(@model, 'change', @onChange)

    @callAllOnChangeAttributes_()

  render: ->
    @onChange(@model)
    @$el.modal('show')

    # HACK: ダイアログを表示して500ms程度待たないと画像のサイズが取得できなかった
    f = ->
      if @readImageSizeflag
        img = $('#character-modal-costume-selector .active img')
        if img.width() > 0
          $('#character-modal-character').css
            width: "#{img.width() / 2}px"
            height: "#{img.height() / 2}px"
          @readImageSizeflag = false
        else
          setTimeout(_.bind(f, @), 50)
    if @readImageSizeflag
      setTimeout(_.bind(f, @), 1)

  callAllOnChangeAttributes_: ->
    @onChangeName(@model, @model.get('name'))
    @onChangeX(@model, @model.get('x'))
    @onChangeY(@model, @model.get('y'))
    @onChangeAngle(@model, @model.get('angle'))
    @onChangeCostumes(@model, @model.get('costumes'))
    @onChangeRotationStyle(@model, @model.get('rotationStyle'))

  onChangeName: (model, value, options) ->
    @$el.find('input[name="character[name]"]').val(value)

  onChangeX: (model, value, options) ->
    @$el.find('input[name="character[x]"]').val(value)
    $('#character_x_value').text(value)
    $('#character-modal-character').css('left', parseInt(value * @previewZoomLevel))

  onChangeY: (model, value, options) ->
    @$el.find('input[name="character[y]"]').val(value)
    $('#character_y_value').text(value)
    $('#character-modal-character').css('top', parseInt(value * @previewZoomLevel))

  onChangeAngle: (model, value, options) ->
    @$el.find('input[name="character[angle]"]').val(value)
    $('#character_angle_value').text("#{value}°")
    rotate = "rotate(#{value}deg)"
    $('#character_angle_vector').css
      '-moz-transform': rotate
      '-webkit-transform': rotate
      transform: rotate

    @model.rotateImage('#character-modal-character')

  onChangeCostumes: (model, value, options) ->
    img = $('<img>').attr
      src: model.costumeUrl()
      alt: model.costume()
    $('#character-modal-character img').replaceWith(img)
    @$el.find('#character-modal-costume-selector a.thumbnail').removeClass('active')
    thumb = @$el.find("#character-modal-costume-selector img[alt=\"#{model.costume()}\"]")
    thumb.parent().addClass('active')
    if thumb.width() > 0
      $('#character-modal-character').css
        width: "#{thumb.width() / 2}px"
        height: "#{thumb.height() / 2}px"
    else
      @readImageSizeflag = true

  onChangeRotationStyle: (model, value, options) ->
    $('#character_rotation_style button.btn').removeClass('btn-primary')
    $("#character_rotation_style_#{value}").addClass('btn-primary')
    @onChangeAngle(@model, @model.get('angle'))

  onChange: (model, options) ->
    return unless @target

    @$el.find('.control-group[for="character[name]"]').removeClass('error')
    @$el.find('#character-modal-ok-button').removeClass('disabled').removeAttr('disabled')

    unless @model.isValid()
      @$el.find('.control-group[for="character[name]"]').addClass('error')
      @$el.find('#character-modal-ok-button').addClass('disabled').attr({ disabled: 'disabled' })

    name = @model.get('name')
    if @target.get('name') != name &&
       Smalruby.Collections.CharacterSet.findWhere({ name: name })
      @$el.find('.control-group[for="character[name]"]').addClass('error')
      @$el.find('#character-modal-ok-button').addClass('disabled').attr({ disabled: 'disabled' })

  onSelectCostume: (e) ->
    e.preventDefault()

    costume = $(e.target).attr('alt') || $(e.target).find('img').attr('alt')

    attrs =
      costumes: [costume]

    unless @nameChanged
      prefix = Smalruby.Character.costumeToNamePrefix(costume)
      if prefix != @model.namePrefix()
        if prefix == @target.namePrefix()
          attrs['name'] = @target.get('name')
        else
          attrs['name'] = Smalruby.Collections.CharacterSet.uniqueName(costume)

    @model.set(attrs)

  onRotationStyleFree: ->
    @model.set({ rotationStyle: 'free' })

  onRotationStyleLeftRight: ->
    @model.set({ rotationStyle: 'left_right' })

  onRotationStyleNone: ->
    @model.set({ rotationStyle: 'none' })

  onOk: ->
    @$el.modal('hide')
    if @target
      @target.set(_.clone(@model.attributes))

  setCharacter: (character)->
    @target = character
    @model.set(_.clone(@target.attributes))
    @nameChanged = false
    @

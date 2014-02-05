# キャラクター設定ダイアログを表現するビュー
Smalruby.CharacterModalView = Backbone.View.extend
  model: new Smalruby.Character()

  events:
    'click #character-modal-costume-selecter a': 'onSelectCostume'
    'click #character-modal-ok-button': 'onOk'

  previewZoomLevel: 0.5

  initialize: ->
    @.target = null

    self = @

    $('#character-modal-character').draggable
      containment: '#character-modal-preview'
      cursor: 'move'
      drag: (event, ui) ->
        pos = ui.position
        self.model.set
          x: pos.left / self.previewZoomLevel
          y: pos.top / self.previewZoomLevel

    $('#character-modal-preview').droppable
      drop: (event, ui) ->
        pos = ui.draggable.position()
        self.model.set
          x: pos.left / self.previewZoomLevel
          y: pos.top / self.previewZoomLevel

    @.$el.find('input[name="character[name]"]').keypress (e) ->
      e = window.event if !e
      if e.keyCode == 13
        false
      else
        true

    @.$el.find('input[name="character[name]"]').change (e)->
      self.model.set({ name: $(@).val() })

    @.$el.find('input[name="character[x]"]').change (e)->
      self.model.set({ x: $(@).val() })

    @.$el.find('input[name="character[y]"]').change (e)->
      self.model.set({ y: $(@).val() })

    @.$el.find('input[name="character[angle]"]').change (e)->
      self.model.set({ angle: $(@).val() })

    @.listenTo(@.model, 'change:name', @.onChangeName)
    @.listenTo(@.model, 'change:x', @.onChangeX)
    @.listenTo(@.model, 'change:y', @.onChangeY)
    @.listenTo(@.model, 'change:angle', @.onChangeAngle)
    @.listenTo(@.model, 'change:costumes', @.onChangeCostumes)

    @.onChange(@.model)

  render: ->
    @.$el.modal('show')

  onChange: (model, options)->
    @.onChangeName(@.model, @.model.get('name'))
    @.onChangeX(@.model, @.model.get('x'))
    @.onChangeY(@.model, @.model.get('y'))
    @.onChangeAngle(@.model, @.model.get('angle'))
    @.onChangeCostumes(@.model, @.model.get('costumes'))

  onChangeName: (model, value, options) ->
    @.$el.find('input[name="character[name]"]').val(value)

  onChangeX: (model, value, options) ->
    @.$el.find('input[name="character[x]"]').val(value)
    $('#character_x_value').text(value)
    $('#character-modal-character').css('left', value * @.previewZoomLevel)

  onChangeY: (model, value, options) ->
    @.$el.find('input[name="character[y]"]').val(value)
    $('#character_y_value').text(value)
    $('#character-modal-character').css('top', value * @.previewZoomLevel)

  onChangeAngle: (model, value, options) ->
    @.$el.find('input[name="character[angle]"]').val(value)
    $('#character_angle_value').text("#{value}°")

  onChangeCostumes: (model, value, options) ->
    img = $('<img>').attr
      src: model.costumeUrl()
      alt: model.costume()
    $('#character-modal-character img').replaceWith(img)
    @.$el.find('#character-modal-costume-selecter a.thumbnail').removeClass('active')
    @.$el.find("#character-modal-costume-selecter img[alt=\"#{model.costume()}\"]").parent().addClass('active')

  onSelectCostume: (e) ->
    e.preventDefault()
    costume = $(e.target).attr('alt') || $(e.target).find('img').attr('alt')
    @.model.set({ costumes: [costume] })

  onOk: ->
    @.$el.modal('hide')
    if @.target
      @.target.set(_.clone(@.model.attributes))

  setCharacter: (character)->
    @.target = character
    @.model.set(_.clone(@.target.attributes))
    @

# ロードダイアログを表現するビュー
Smalruby.LoadModalView = Backbone.View.extend
  events:
    'click #load-modal-ok-button': 'onOk'

  initialize: ->

  render: ->
    @$el.modal('show')

  onOk: ->
    @$el.modal('hide')

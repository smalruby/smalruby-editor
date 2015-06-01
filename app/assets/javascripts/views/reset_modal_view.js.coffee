# リセット確認ダイアログを表現するビュー
Smalruby.ResetModalView = Backbone.View.extend
  events:
    'click #reset-modal-ok-button': 'onOk'

  initialize: ->
    Smalruby.removeBackdropOnHidden(@$el)

  render: ->
    @$el.modal
      backdrop: 'static'
    @$el.modal('show')

  onOk: (e) ->
    Smalruby.reset()
    @$el.modal('hide')

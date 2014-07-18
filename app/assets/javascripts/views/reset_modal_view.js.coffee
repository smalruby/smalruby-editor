# リセット確認ダイアログを表現するビュー
Smalruby.ResetModalView = Backbone.View.extend
  events:
    'click #reset-modal-ok-button': 'onOk'

  render: ->
    @$el.modal('show')

  onOk: (e) ->
    Smalruby.reset()
    @$el.modal('hide')

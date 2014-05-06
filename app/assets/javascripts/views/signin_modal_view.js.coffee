# ログインダイアログを表現するビュー
Smalruby.SigninModalView = Backbone.View.extend
  events:
    'click #signin-modal-ok-button': 'onOk' # FIXME: 本当は#signin-modal .ok-buttonを指定したいができなかった

  initialize: ->
    Smalruby.ignoreEnterKey(@$el)
    @$el.on 'shown', =>
      @$el.find('#signin-modal-username')
        .focus()

  render: ->
    @$el.find('#signin-modal-username')
      .val($('#username-label').text())
    @$el.modal('show')

  onOk: (e) ->
    username = @$el.find('input[name=username]').val()
    $.post('/sessions/', { username: username })
      .then(
        (data) ->
          $('#signin-button').hide()
          $('#signout-button').show()
          $('#username-label').text(data)
          $('#username-button').show()
          successMessage('ログインしました')
          new $.Deferred().resolve().promise()
        ->
          errorMessage('ログインに失敗しました')
          new $.Deferred().resolve().promise()
      )
      .done =>
        @$el.modal('hide')

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  textEditor = ace.edit('text-editor')
  textEditor.setTheme('ace/theme/clouds')
  textEditor.setShowInvisibles(true)

  session = textEditor.getSession()
  session.setMode('ace/mode/ruby')
  session.setTabSize(2)
  session.setUseSoftTabs(true)

  # FIXME: エディタの切り替え機能を実装するときに以下の処理を削除する。
  #   なお、navbarの中のリンクの見た目をよくするためにa要素を使っているのだが、
  #   デフォルトではRubyをクリックするとリンク先に遷移してしまう。そこでリンク
  #   をクリックしてもリンク先に遷移しないようにしている。
  $('ul.nav li a').on('click', (e) ->
    e.preventDefault()
    false
  )

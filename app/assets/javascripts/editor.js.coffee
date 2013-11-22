# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  editor = ace.edit("editor")
  editor.setTheme("ace/theme/clouds")
  editor.setShowInvisibles(true)

  session = editor.getSession()
  session.setMode("ace/mode/ruby")
  session.setTabSize(2)
  session.setUseSoftTabs(true)

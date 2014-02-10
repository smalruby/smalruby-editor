window.Smalruby =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    # HACK: Underscoreのテンプレートの<%, %>はHamlと組み合わせたときに
    #   HTML要素の属性がHamlによってエスケープされてしまうため使いにく
    #   い。そこで、それぞれ{{, }}に変更する。
    _.extend(_.templateSettings, {
      escape: /{{-([\s\S]+?)}}/
      evaluate: /{{([\s\S]+?)}}/
      interpolate: /{{=([\s\S]+?)}}/
    })

    @Collections.CharacterSet = new Smalruby.CharacterSet()

    @Views.MainMenuView = new Smalruby.MainMenuView()
    @Views.CharacterSelectorView = new Smalruby.CharacterSelectorView
      model: @Collections.CharacterSet
    @Views.CharacterModalView = new Smalruby.CharacterModalView
      el: $('#character-modal')

  loadXml: (data, workspace = Blockly.mainWorkspace) ->
    xml = Blockly.Xml.textToDom(data)
    workspace.clear()
    chars = []
    i = 0
    while (xmlChild = xml.childNodes[i])
      if xmlChild.nodeName.toLowerCase() == 'character'
        c = new Smalruby.Character
          name: xmlChild.getAttribute('name')
          costumes: xmlChild.getAttribute('costumes').split(',')
          x: parseInt(xmlChild.getAttribute('x'), 10)
          y: parseInt(xmlChild.getAttribute('y'), 10)
          angle: parseInt(xmlChild.getAttribute('angle'), 10)
        chars.push(c)
      i++
    Smalruby.Collections.CharacterSet.reset(chars)
    Blockly.Xml.domToWorkspace(workspace, xml)

  dumpXml: (workspace = Blockly.mainWorkspace, charSet = Smalruby.Collections.CharacterSet) ->
    xmlDom = Blockly.Xml.workspaceToDom(workspace)
    blocklyDom = xmlDom.firstChild
    charSet.each (c) ->
      e = goog.dom.createDom('character')
      e.setAttribute('x', c.get('x'))
      e.setAttribute('y', c.get('y'))
      e.setAttribute('name', c.get('name'))
      e.setAttribute('costumes', c.get('costumes').join(','))
      e.setAttribute('angle', c.get('angle'))
      xmlDom.insertBefore(e, blocklyDom)
    Blockly.Xml.domToPrettyText(xmlDom)

$(document).ready ->
  Smalruby.initialize()

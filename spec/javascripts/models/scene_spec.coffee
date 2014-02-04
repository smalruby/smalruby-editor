describe 'Smalruby.Scene', ->
  self = null

  beforeEach ->
    self = new Smalruby.Scene

  describe 'プロパティのデフォルト値', ->
    it 'width: 640', ->
      expect(self.get('width')).to.equal(640)

    it 'height: 480', ->
      expect(self.get('height')).to.equal(480)

    it "color: 'black'", ->
      expect(self.get('color')).to.equal('black')

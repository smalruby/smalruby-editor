describe 'Smalruby.Character', ->
  klass = Smalruby.Character
  self = null

  beforeEach ->
    self = new klass
      name: 'car1'
      costumes: [
        'car1.png'
        'car2.png'
      ]

  describe 'プロパティのデフォルト値', ->
    beforeEach ->
      self = new klass()

    it 'name: null', ->
      expect(self.get('name')).to.be(null)

    it 'costumes: PRESET_COSTUMESの1番目の要素のみの配列', ->
      expect(_.isEqual(self.get('costumes'), [klass.PRESET_COSTUMES[0]])).to.be(true)

    it 'costumeIndex: 0', ->
      expect(self.get('costumeIndex')).to.equal(0)

    it 'x: 0', ->
      expect(self.get('x')).to.equal(0)

    it 'y: 0', ->
      expect(self.get('y')).to.equal(0)

    it 'angle: 0', ->
      expect(self.get('angle')).to.equal(0)

    it 'visible: true', ->
      expect(self.get('visible')).to.be(true)

    it 'using: false', ->
      expect(self.get('using')).to.be(false)

  describe '#initialize', ->
    describe 'costumesを指定した場合', ->
      it 'costumesが指定したものになる', ->
        expect(_.isEqual(self.get('costumes'), ['car1.png', 'car2.png'])).to.be(true)

  describe '#validate', ->
    it 'nameは指定しなければいけない', ->
      self.set({ name: '' })
      expect(self.isValid()).to.not.be.ok()
      self.set({ name: null })
      expect(self.isValid()).to.not.be.ok()
      self.set({ name: undefined })
      expect(self.isValid()).to.not.be.ok()

    describe 'nameはRubyの変数名として正しくなければいけない', ->
      invalidNames = [
        '1'
        'CONSTANT'
        '-abc'
        '[1, 2, 3]'
        '{ a: 1, b: 2}'
        ':symbol'
        'abc{'
        'abc['
        'abc:def'
      ]
      for name in invalidNames
        do (name) ->
          it "#{name}は不正であること", ->
            self.set({ name: name })
            expect(self.isValid()).to.not.be.ok()

      invalidNames = [
        'one'
        'constant'
        'o1e'
        'あいうえお'
      ]
      for name in invalidNames
        do (name) ->
          it "#{name}は正しいこと", ->
            self.set({ name: name })
            expect(self.isValid()).to.be.ok()

  describe '#namePrefix', ->
    it 'car', ->
      expect(self.namePrefix()).to.equal('car')

  describe '#costume', ->
    it 'car1.pngであること', ->
      expect(self.costume()).to.equal('car1.png')

  describe '#costumeUrl', ->
    it 'プレフィックスが/smalruby/assets/であること', ->
      expect(self.costumeUrl()).to.equal('/smalruby/assets/car1.png')

  describe '#nextCostume', ->
    it 'costumeIndexをインクリメントすること', ->
      expect(self.get('costumeIndex')).to.equal(0)
      self.nextCostume()
      expect(self.get('costumeIndex')).to.equal(1)

    it 'コスチュームの最大値までいったら0に戻ること', ->
      self.set({ costumeIndex: 1 })
      self.nextCostume()
      expect(self.get('costumeIndex')).to.equal(0)

    it '次のコスチューム番号を返すこと', ->
      expect(self.nextCostume()).to.equal(1)

  describe '#link', ->
    linkObject = null

    beforeEach ->
      linkObject =
        name: 'any object'

    it '任意のオブジェクトと結びつきusingプロパティをtrueにできること', ->
      self.link(linkObject)
      expect(self.get('using')).to.be.ok()

    it '自分自身を返すこと', ->
      expect(self.link(linkObject)).to.be(self)

  describe '#unlink', ->
    linkedObjects = null

    beforeEach ->
      linkedObjects = [
        { name: 'any object 1' }
        { name: 'any object 2' }
        { name: 'any object 3' }
      ]
      self.link(o) for o in linkedObjects

    it '任意のオブジェクトとの結びつきを解除してusingプロパティをfalseにできること', ->
      self.unlink(o) for o in linkedObjects
      expect(self.get('using')).to.not.be.ok()

    it 'すべてのオブジェクトとの結びつきを解除するまではusingプロパティがtrueのままであること', ->
      self.unlink(linkedObjects[0])
      expect(self.get('using')).to.be.ok()
      self.unlink(linkedObjects[1])
      expect(self.get('using')).to.be.ok()
      self.unlink(linkedObjects[2])
      expect(self.get('using')).to.not.be.ok()

    it '解除済みのオブジェクトを指定しても例外が発生しないこと', ->
      self.unlink(linkedObjects[0])
      expect(-> self.unlink(linkedObjects[0])).to.not.throwException()

    it '自分自身を返すこと', ->
      expect(self.unlink(linkedObjects[0]))

  describe '.PRESET_COSTUMES', ->
    it '文字列の配列であること', ->
      expect(klass.PRESET_COSTUMES).to.be.a('array')
      expect(klass.PRESET_COSTUMES[0]).to.be.a('string')

  describe '.costumeToNamePrefix', ->
    args = [
      'car1.png'
      'car1'
      'car'
      'http://example.com/car1.png'
      'http://example.com/car1'
      'http://example.com/car'
    ]
    for arg in args
      do (arg) ->
        describe arg, ->
          it 'car', ->
            expect(klass.costumeToNamePrefix(arg)).to.equal('car')

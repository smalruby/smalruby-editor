describe 'Smalruby.Character', ->
  klass = Smalruby.Character
  self = null

  beforeEach ->
    self = new Smalruby.Character
      name: 'car1'
      costumes: [
        'car1.png'
        'car2.png'
      ]

  describe 'プロパティのデフォルト値', ->
    beforeEach ->
      self = new Smalruby.Character()

    it 'name: null', ->
      expect(self.get('name')).to.be(null)

    it 'costumes: PRESET_COSTUMESの1番目の要素のみの配列', ->
      expect(_.isEqual(self.get('costumes'), [Smalruby.Character.PRESET_COSTUMES[0]])).to.be(true)

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

  describe '#namePrefix', ->
    it 'car', ->
      expect(self.namePrefix()).to.equal('car')

  describe '#costume', ->
    it 'car1.pngであること', ->
      expect(self.costume()).to.equal('car1.png')

  describe '#costumeUrl', ->
    describe 'プリセットの場合', ->
      it 'プレフィックスが/smalruby/assets/であること', ->
        expect(self.costumeUrl()).to.equal('/smalruby/assets/car1.png')

    describe 'プリセットではない場合', ->
      beforeEach ->
        self = new Smalruby.Character
          costumes: [
            'http://example.com/car1.png'
            'http://example.com/car2.png'
          ]

      it 'costumeの値であること', ->
        expect(self.costumeUrl()).to.equal(self.costume())

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

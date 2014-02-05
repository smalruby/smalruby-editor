describe 'Smalruby.Character', ->
  self = null

  beforeEach ->
    self = new Smalruby.Character
      costumes: [
        'car1.png'
        'car2.png'
      ]

  describe 'プロパティのデフォルト値', ->
    beforeEach ->
      self = new Smalruby.Character

    it 'name: PRESET_COSTUMESの1番目の要素の拡張子を除いたもの', ->
      expect(self.get('name')).to.equal('car1')

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
    it 'nameにcostumesの1番目の要素の拡張子を除いたものが設定されていること', ->
      expect(self.get('name')).to.equal('car1')

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
      expect(Smalruby.Character.PRESET_COSTUMES).to.be.a('array')
      expect(Smalruby.Character.PRESET_COSTUMES[0]).to.be.a('string')

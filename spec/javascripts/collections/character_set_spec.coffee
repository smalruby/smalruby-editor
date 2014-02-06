describe 'Smalruby.CharacterSet', ->
  klass = Smalruby.CharacterSet
  self = null

  beforeEach ->
    self = new klass()

  describe '#uniqueName', ->
    describe 'costumeを省略した場合', ->
      it 'プリセットコスチュームの最初の要素名からユニークな名前を求めること', ->
        expect(self.uniqueName()).to.equal('car1')

    describe 'キャラクターが1つもない場合', ->
      it 'car1を返すこと', ->
        expect(self.uniqueName('car1.png')).to.equal('car1')

      it '2回以降の呼び出しでもcar1を返すこと', ->
        num = 5
        while num -= 1
          expect(self.uniqueName('car1.png')).to.equal('car1')

    describe 'キャラクターが複数ある場合', ->
      beforeEach ->
        self.add(new Smalruby.Character({ name: 'car1' }))
        self.add(new Smalruby.Character({ name: 'car3' }))
        self.add(new Smalruby.Character({ name: 'ball4' }))
        self.add(new Smalruby.Character({ name: 'cat1' }))

      it '添え字が最大となるものを返す', ->
        expect(self.uniqueName('car1.png')).to.equal('car4')
        expect(self.uniqueName('car4.png')).to.equal('car4')
        expect(self.uniqueName('car5.png')).to.equal('car4')
        expect(self.uniqueName('ball1.png')).to.equal('ball5')
        expect(self.uniqueName('ball5.png')).to.equal('ball5')
        expect(self.uniqueName('ball6.png')).to.equal('ball5')
        expect(self.uniqueName('cat1.png')).to.equal('cat2')
        expect(self.uniqueName('cat3.png')).to.equal('cat2')

        expect(self.uniqueName('http://example.com/cat3.png')).to.equal('cat2')
        expect(self.uniqueName('http://example.com/cat3')).to.equal('cat2')
        expect(self.uniqueName('cat3')).to.equal('cat2')

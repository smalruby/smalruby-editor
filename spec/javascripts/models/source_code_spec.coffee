describe 'Smalruby.SourceCode', ->
  klass = Smalruby.SourceCode
  self = null

  describe '#getRbxmlFilename', ->
    describe 'filenameが01.rbのとき', ->
      beforeEach ->
        self = new klass
          filename: '01.rb'
          data: 'puts "Hello, World!"'

      it '01.rb.xmlを返すこと', ->
        expect(self.getRbxmlFilename()).to.equal('01.rb.xml')

    describe 'filenameが01のとき', ->
      beforeEach ->
        self = new klass
          filename: '01'
          data: 'puts "Hello, World!"'

      it '01.rb.xmlを返すこと', ->
        expect(self.getRbxmlFilename()).to.equal('01.rb.xml')

    describe 'filenameが01.xmlのとき', ->
      beforeEach ->
        self = new klass
          filename: '01.xml'
          data: 'puts "Hello, World!"'

      it '01.rb.xmlを返すこと', ->
        expect(self.getRbxmlFilename()).to.equal('01.rb.xml')

    describe 'filenameが01.rb.xmlのとき', ->
      beforeEach ->
        self = new klass
          filename: '01.rb.xml'
          data: 'puts "Hello, World!"'

      it '01.rb.xmlを返すこと', ->
        expect(self.getRbxmlFilename()).to.equal('01.rb.xml')

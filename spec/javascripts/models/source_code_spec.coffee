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

  describe '.defaultFilename', ->
    it 'program_<日付>.rbを返すこと', ->
      now = new Date(2015, 2 - 1, 10, 12, 10, 59)
      expect(Smalruby.SourceCode.defaultFilename(now)).to.equal('program_150210_121059.rb')

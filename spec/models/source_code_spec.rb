# -*- coding: utf-8 -*-
require 'spec_helper'

describe SourceCode, 'Rubyのソースコードを表現するモデル' do
  describe 'validation' do
    describe 'filename' do
      specify 'ディレクトリセパレータを含むことはできない' do
        sc = SourceCode.new(filename: '/etc/passwd')
        expect(sc).not_to be_valid
        expect(sc.errors[:filename])
          .to include('includes directory separator(s)')
      end
    end
  end

  describe '.make_remix_filename', 'リミックス用のファイル名を生成する' do
    subject {
      home_dir = Rails.root.join('spec/fixtures/files')
      SourceCode.make_remix_filename(home_dir.to_s, filename)
    }

    {
      '01.rb' => '01_remix03.rb',
      '01.rb.xml' => '01_remix03.rb.xml',
      '01_remix.rb' => '01_remix03.rb',
      '01_remix02.rb' => '01_remix03.rb',
      '01_remix03.rb' => '01_remix03.rb',
      '02.rb' => '02_remix.rb',
      '02.rb.xml' => '02_remix.rb.xml',
    }.each do |_filename, _expected|
      describe _filename do
        let(:filename) { _filename }

        it { should eq(_expected) }
      end
    end
  end

  describe '#check_syntax', 'シンタックスをチェックする' do
    let(:source_code) {
      SourceCode.new(data: data)
    }

    subject { source_code.check_syntax }

    context 'シンタックスが正しい場合' do
      let(:data) { 'puts "Hello, World!"' }

      it { should be_empty }
    end

    context 'シンタックスが正しくない場合' do
      let(:data) { 'puts Hello, World!"' }

      it { should_not be_empty }
      it {
        should include(row: 1, column: 19,
                       message: 'syntax error, unexpected tSTRING_BEG,' \
                       " expecting keyword_do or '{' or '('")
      }
      it {
        should include(row: 1, column: 0,
                       message: 'unterminated string meets end of file')
      }
    end
  end

  describe '#digest', 'プログラムのハッシュ値を計算する' do
    let(:data) { 'puts "Hello, World!"' }
    let(:source_code) {
      SourceCode.new(data: data)
    }

    subject { source_code.digest }

    it { should eq(Digest::SHA256.hexdigest(data)) }
  end

  describe '#summary', 'プログラムの概要を取得する' do
    describe 'XML形式' do
      let(:xml_path) { rb_path + '.xml' }
      let(:data) { Rails.root.join(xml_path).read }
      let(:source_code) {
        SourceCode.new(filename: File.basename(xml_path), data: data)
      }

      subject { source_code.summary }

      {
        car_chase: {
          title: '車のおいかけっこ',
          filename: 'car_chase.rb',
          imageUrl: '/smalruby/assets/car2.png',
        },
        star: {
          title: 'クリックスターだにゃ～',
          filename: 'star.rb',
          imageUrl: '/smalruby/assets/cat1.png',
        },
        pong: {
          title: 'ピンポンゲーム',
          filename: 'pong.rb',
          imageUrl: '/smalruby/assets/cat2.png',
        },
        hardware_led: {
          title: 'ライトをぴかっとさせるでよ',
          filename: 'hardware_led.rb',
          imageUrl: '/smalruby/assets/frog1.png',
        },
        adjust_2wd_car: {
          title: '2WD車の左右のモーターを調整する',
          filename: 'adjust_2wd_car.rb',
          imageUrl: '/smalruby/assets/car2.png',
        },
      }.each do |name, summary|
        _rb_path = "demos/#{name}.rb"
        context "'#{_rb_path + '.xml'}'" do
          let(:rb_path) { _rb_path }

          summary.each do |key, value|
            describe key do
              subject { super()[key] }

              it { should eq(value) }
            end
          end
        end
      end

      context 'no comment and filename is no_comment.rb' do
        let(:rb_path) { 'no_comment.rb' }
        let(:data) { '<xml></xml>' }

        %i(filename title).each do |key|
          describe key do
            subject { super()[key] }

            it { should eq(rb_path) }
          end
        end
      end
    end
  end

  describe '#include_block?' do
    describe 'XML形式' do
      let(:data) { Rails.root.join(xml_path).read }
      let(:source_code) {
        SourceCode.new(filename: File.basename(xml_path), data: data)
      }

      subject { source_code.include_block?(type) }

      context 'ソースコードにハードウェア関連ブロックを含む場合' do
        let(:xml_path) { 'demos/adjust_2wd_car.rb.xml' }

        context '引数にhardware_init_hardwareを指定する' do
          let(:type) { 'hardware_init_hardware' }

          it { should be_true }
        end

        context '引数にハードウェア関連ブロックを指定する' do
          let(:type) { /^hardware_/ }

          it { should be_true }
        end

        context '引数にpen_down_penを指定する' do
          let(:type) { 'pen_down_pen' }

          it { should be_false }
        end

        context '引数にペン関連ブロックを指定する' do
          let(:type) { /^pen_/ }

          it { should be_false }
        end
      end

      context 'ソースコードにハードウェア関連ブロックを含まない場合' do
        let(:xml_path) { 'demos/star.rb.xml' }

        context '引数にhardware_init_hardwareを指定する' do
          let(:type) { 'hardware_init_hardware' }

          it { should be_false }
        end

        context '引数にハードウェア関連ブロックを指定する' do
          let(:type) { /^hardware_/ }

          it { should be_false }
        end

        context '引数にpen_down_penを指定する' do
          let(:type) { 'pen_down_pen' }

          it { should be_true }
        end

        context '引数にペン関連ブロックを指定する' do
          let(:type) { /^pen_/ }

          it { should be_true }
        end
      end
    end
  end

  describe '#xml?' do
    let(:source_code) {
      SourceCode.new(filename: File.basename(path))
    }

    subject { source_code.xml? }

    context 'a' do
      let(:path) { 'car1.rb' }

      it { should be_false }
    end

    context 'b' do
      let(:path) { 'car1.rb.xml' }

      it { should be_true }
    end
  end
end

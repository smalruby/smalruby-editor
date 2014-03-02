# -*- coding: utf-8 -*-
require 'spec_helper'

describe SourceCodesController do
  describe 'プログラムが正しいかチェックする (XHR POST check)' do
    before do
      params = {
        source_code: {
          data: data,
        }
      }.with_indifferent_access

      xhr :post, :check, params
    end

    context 'プログラムが正しい場合' do
      let(:data) { 'puts "Hello, World!"' }

      it { expect(response).to be_success }

      it do
        expected = parse_json(SourceCode.new(data: data).check_syntax.to_json)
        expect(parse_json(response.body)).to eq(expected)
      end
    end

    context 'プログラムが正しくない場合' do
      let(:data) { 'puts Hello, World!"' }

      it { expect(response).to be_success }

      it do
        expected = parse_json(SourceCode.new(data: data).check_syntax.to_json)
        expect(parse_json(response.body)).to eq(expected)
      end
    end
  end

  describe 'プログラムを保存する (XHR POST create)' do
    let(:params) {
      {
        source_code: {
          filename: '01.rb',
          data: 'puts "Hello, World!"',
        }
      }
    }

    describe 'レスポンス' do
      subject {
        xhr :post, :create, params
        response
      }

      it { should be_success }
      it {
        ids = SourceCode.all.map(&:id)
        expect(parse_json(subject.body))
          .to eq('source_code' => {
                   'id' => SourceCode.find(SourceCode.all.map(&:id) - ids)
                     .first.id
                 })
      }
    end

    it 'アップロードされたプログラムを保存できる' do
      expect {
        xhr :post, :create, params
      }.to change { SourceCode.count }.by(1)
    end

    describe 'アップロードされたプログラム' do
      subject {
        ids = SourceCode.all.map(&:id)
        xhr :post, :create, params
        SourceCode.find((SourceCode.all.map(&:id) - ids).first)
      }

      its(:data) { should eq(params[:source_code][:data]) }
      its(:filename) { should eq(params[:source_code][:filename]) }
    end

    describe 'session' do
      before {
        ids = SourceCode.all.map(&:id)
        xhr :post, :create, params
        @created_source_code =
          SourceCode.find((SourceCode.all.map(&:id) - ids).first)
      }

      subject { session }

      it '[:source_code][:id]はアップロードしたプログラムのIDである' do
        expect(subject[:source_code][:id]).to eq(@created_source_code.id)
      end

      it '[:source_code][:digest]はアップロードしたプログラムのSHA256のハッシュ値である' do
        expect(subject[:source_code][:digest])
          .to eq(@created_source_code.digest)
      end
    end
  end

  describe 'プログラムをダウンロードしてサーバ上から削除する (DELETE download)' do
    let(:source_code) {
      SourceCode.create!(filename: '01.rb', data: 'puts "Hello, World!"')
    }

    context 'セッションが正しい場合' do
      let(:_session) {
        {
          source_code: {
            id: source_code.id,
            digest: source_code.digest,
          }
        }
      }

      context 'ファイル名が半角英数字の場合' do
        before do
          allow(@controller).to receive(:send_data).and_call_original
          delete :download, {}, _session
        end

        specify 'プログラムをダウンロードする' do
          expect(@controller).to have_received(:send_data)
            .with(source_code.data,
                  filename: source_code.filename,
                  disposition: 'attachment',
                  type: 'text/plain; charset=utf-8')
            .once
        end

        specify 'プログラムをサーバ上から削除する' do
          expect(SourceCode).to have(0).records
        end

        specify 'セッションから[:source_code]を削除する' do
          expect(session[:source_code]).to be_nil
        end
      end

      context 'ファイル名が日本語の場合' do
        # rubocop:disable LineLength
        USER_AGENT = {
          IE11: 'Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; Touch; rv:11.0) like Gecko',
          IE10: 'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0; Touch)',
          Chrome20: 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.57 Safari/536.11',
          Firefox14: 'Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20100101 Firefox/14.0.1',
        }
        # rubocop:enable LineLength

        let(:source_code) {
          SourceCode.create!(filename: '日本語.rb', data: 'puts "Hello, World!"')
        }

        [:IE10, :IE11].each do |browser|
          context "ブラウザが#{browser}の場合" do
            before do
              @request.env['HTTP_USER_AGENT'] = USER_AGENT[browser]
              allow(@controller).to receive(:send_data).and_call_original
              delete :download, {}, _session
            end

            specify 'プログラムをダウンロードする' do
              expect(@controller).to have_received(:send_data)
                .with(source_code.data,
                      filename: ERB::Util.url_encode(source_code.filename),
                      disposition: 'attachment',
                      type: 'text/plain; charset=utf-8')
                .once
            end
          end
        end

        [:Chrome20, :Firefox14].each do |browser|
          context "ブラウザが#{browser}の場合" do
            before do
              @request.env['HTTP_USER_AGENT'] = USER_AGENT[browser]
              allow(@controller).to receive(:send_data).and_call_original
              delete :download, {}, _session
            end

            specify 'プログラムをダウンロードする' do
              expect(@controller).to have_received(:send_data)
                .with(source_code.data,
                      filename: source_code.filename,
                      disposition: 'attachment',
                      type: 'text/plain; charset=utf-8')
                .once
            end
          end
        end
      end
    end

    context 'セッションが不正な場合' do
      shared_examples 'raise exception' do
        it {
          expect {
            delete :download, {}, _session
          }.to raise_exception
        }
      end

      context 'セッションに[:source_code]がない場合' do
        let(:_session) { {} }

        include_examples 'raise exception'
      end

      context 'セッションに[:source_code][:id]がない場合' do
        let(:_session) {
          {
            source_code: {
              digest: source_code.digest,
            }
          }
        }

        include_examples 'raise exception'
      end

      context 'セッションに[:source_code][:digest]がない場合' do
        let(:_session) {
          {
            source_code: {
              id: source_code.id,
            }
          }
        }

        include_examples 'raise exception'
      end

      context 'セッションの[:source_code][:digest]が不正な場合' do
        let(:_session) {
          {
            source_code: {
              id: source_code.id,
              digest: 'invalid_digest',
            }
          }
        }

        include_examples 'raise exception'
      end
    end
  end

  describe 'プログラムをホームディレクトリに保存してサーバ上から削除する' \
           ' (DELETE write)' do
    let(:source_code) {
      SourceCode.create!(filename: '01.rb', data: 'puts "Hello, World!"')
    }
    let(:params) { {} }
    let(:_session) {
      {
        source_code: {
          id: source_code.id,
          digest: source_code.digest,
        }
      }
    }

    context 'RAILS_ENVがstandaloneの場合', set_standalone_rails_env: true do
      let(:path) { Pathname("~/#{source_code.filename}").expand_path.to_s }

      context 'セッションが正しい場合' do
        shared_examples 'success writing' do
          let(:target_file) {
            f = double('File')
            allow(f).to receive(:write)
            f
          }

          before do
            allow(File).to receive(:open).and_yield(target_file)
            xhr :delete, :write, params, _session
          end

          specify { expect(response).to be_success }

          specify 'ホームディレクトリにファイルを保存する' do
            expect(File).to have_received(:open).with(path, 'w').once
            expect(target_file)
              .to have_received(:write).with(source_code.data).once
          end

          specify 'プログラムをサーバ上から削除する' do
            expect(SourceCode).to have(0).records
          end

          specify 'セッションから[:source_code]を削除する' do
            expect(session[:source_code]).to be_nil
          end
        end

        context '同じ名前のファイルが存在しない場合' do
          before do
            allow(File).to receive(:exist?).with(path).and_return(false)
          end

          context 'ファイル名が半角英数字の場合' do
            include_examples 'success writing'
          end

          context 'ファイル名が日本語の場合' do
            let(:source_code) {
              SourceCode.create!(filename: '日本語でも表現できる.rb',
                                 data: 'puts "Hello, World!"')
            }

            include_examples 'success writing'
          end
        end

        context '同じ名前のファイルが存在する場合' do
          before do
            allow(File).to receive(:exist?).with(path).and_return(true)
          end

          context '上書き保存モードの場合' do
            let(:params) { { force: true } }

            include_examples 'success writing'
          end

          context '上書き保存モードではない場合' do
            before do
              xhr :delete, :write, params, _session
            end

            specify 'プログラムをサーバ上から削除しない' do
              expect(SourceCode).to have(1).records
            end

            specify 'セッションから[:source_code]を削除しない' do
              expect(session[:source_code]).to eq(_session[:source_code])
            end
          end
        end
      end

      context 'セッションが不正な場合' do
        shared_examples 'raise exception' do
          it {
            expect {
              xhr :delete, :write, params, _session
            }.to raise_exception
          }
        end

        context 'セッションに[:source_code]がない場合' do
          let(:_session) { {} }

          include_examples 'raise exception'
        end

        context 'セッションに[:source_code][:id]がない場合' do
          let(:_session) {
            {
              source_code: {
                digest: source_code.digest,
              }
            }
          }

          include_examples 'raise exception'
        end

        context 'セッションに[:source_code][:digest]がない場合' do
          let(:_session) {
            {
              source_code: {
                id: source_code.id,
              }
            }
          }

          include_examples 'raise exception'
        end

        context 'セッションの[:source_code][:digest]が不正な場合' do
          let(:_session) {
            {
              source_code: {
                id: source_code.id,
                digest: 'invalid_digest',
              }
            }
          }

          include_examples 'raise exception'
        end
      end
    end

    context 'RAILS_ENVがstandalone以外の場合' do
      subject do
        xhr :delete, :write, params, _session
      end

      it { expect { subject }.to raise_exception }

      it 'プログラムをサーバ上から削除しない' do
        begin
          subject
        rescue
          expect(SourceCode).to have(1).records
        end
      end

      it 'セッションから[:source_code]を削除しない' do
        begin
          subject
        rescue
          expect(session[:source_code]).to eq(_session[:source_code])
        end
      end
    end
  end

  describe 'プログラムを読み込む (POST load)' do
    before do
      post :load, source_code: { file: load_file }
    end

    describe '正常系' do
      let(:load_file) { fixture_file_upload('files/01.rb', 'text/plain') }

      it { expect(response).to be_success }

      it 'アップロードされたプログラムの情報をJSON形式でダウンロードできる' do
        load_file.rewind
        expected = {
          source_code: {
            filename: load_file.original_filename,
            type: load_file.content_type,
            size: load_file.size,
            data: load_file.read.force_encoding('utf-8'),
          }
        }.to_json
        expect(response.body).to be_json_eql(expected)
      end
    end

    describe '異常系' do
      context '画像をアップロードした場合' do
        let(:load_file) {
          fixture_file_upload('files/favicon.ico', 'application/octet-stream')
        }

        it { expect(response).to be_success }

        it 'エラーを返す' do
          info = {
            filename: load_file.original_filename,
            error: 'Rubyのプログラムではありません',
          }
          info.each do |path, value|
            expect(response.body)
              .to include_json(value.to_json).at_path("source_code/#{path}")
          end
        end
      end
    end
  end

  describe 'プログラムをXML形式のブロックに変換する (POST to_blocks)' do
    let(:data) { 'data' }

    before do
      allow_any_instance_of(SourceCode).to receive(:to_blocks) {
        fail if data == '__FAIL__'
        'success'
      }

      post :to_blocks, source_code: { data: data }
    end

    context '成功する場合' do
      it 'SourceCode#to_blocksの結果をそのまま返すこと' do
        expect(response.body).to eq('success')
      end
    end

    context '失敗する場合' do
      let(:data) { '__FAIL__' }

      it { expect(response.status).to eq(400) }
    end
  end
end

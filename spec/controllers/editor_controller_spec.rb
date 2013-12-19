# -*- coding: utf-8 -*-
require 'spec_helper'
require 'nkf'

describe EditorController do
  describe 'エディタ画面を表示する (GET index)' do
    it 'returns http success' do
      get :index
      response.should be_success
    end
  end

  describe 'プログラムをダウンロードしてサーバ上から削除する (DELETE destroy_file)' do
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

      before do
        allow(@controller).to receive(:send_data).and_call_original
        delete :destroy_file, {}, _session
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

    context 'セッションが不正な場合' do
      shared_examples 'raise exception' do
        it {
          expect {
            delete :destroy_file, {}, _session
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

  describe 'プログラムを読み込む (POST load_file)' do
    before do
      post :load_file, load_file: load_file
    end

    describe '正常系' do
      let(:load_file) { fixture_file_upload('files/01.rb', 'text/plain') }

      it { expect(response).to be_success }

      it 'アップロードされたプログラムの情報をJSON形式でダウンロードできる' do
        load_file.rewind
        file = {
          name: load_file.original_filename,
          type: load_file.content_type,
          size: load_file.size,
          source: load_file.read.force_encoding('utf-8'),
        }
        expect(response.body).to be_json_eql(file.to_json)
      end
    end

    describe '異常系' do
      context '画像をアップロードした場合' do
        let(:load_file) {
          fixture_file_upload('files/favicon.ico', 'application/octet-stream')
        }

        it { expect(response).to be_success }

        it 'エラーを返す' do
          file = {
            name: load_file.original_filename,
            error: 'Rubyのプログラムではありません',
          }
          file.each do |path, value|
            expect(response.body)
              .to include_json(value.to_json).at_path(path.to_s)
          end
        end
      end
    end
  end
end

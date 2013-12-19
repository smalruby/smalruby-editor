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
end

# -*- coding: utf-8 -*-
require 'spec_helper'
require 'nkf'

describe EditorController do
  describe "エディタ画面を表示する (GET 'index')" do
    it 'returns http success' do
      get 'index'
      response.should be_success
    end
  end

  describe "プログラムを保存する (GET 'save_file')" do
    it 'アップロードされたプログラムをダウンロードできる' do
      params = {
        filename: '01.rb',
        source: 'puts "Hello, World!"',
      }.with_indifferent_access

      expect(@controller).to receive(:send_data)
        .with(params[:source], filename: params[:filename],
              disposition: 'attachment',
              type: 'text/plain; charset=utf-8')
        .once.and_call_original

      get 'save_file', params

      expect(response).to be_success
    end
  end

  describe "プログラムを読み込む (POST 'load_file')" do
    before do
      post 'load_file', load_file: load_file
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
        let(:load_file) { fixture_file_upload('files/favicon.ico',
                                              'application/octet-stream') }

        it { expect(response).to be_success }

        it 'エラーを返す' do
          file = {
            name: load_file.original_filename,
            error: 'Rubyのプログラムではありません',
          }
          file.each do |path, value|
            expect(response.body).to include_json(value.to_json).at_path(path.to_s)
          end
        end
      end
    end
  end
end

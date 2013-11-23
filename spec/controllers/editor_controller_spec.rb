# -*- coding: utf-8 -*-
require 'spec_helper'

describe EditorController do

  describe "エディタ画面を表示する (GET 'index')" do
    it 'returns http success' do
      get 'index'
      response.should be_success
    end
  end

  describe "プログラムを保存する (POST 'save')" do
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

      get 'save', params

      expect(response).to be_success
    end
  end
end

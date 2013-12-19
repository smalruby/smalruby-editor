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
end

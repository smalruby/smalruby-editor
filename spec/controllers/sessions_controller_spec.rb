# -*- coding: utf-8 -*-
require 'spec_helper'

describe SessionsController do
  describe 'ログインする (XHR POST create)' do
    let(:params) {
      {
        username: '1102',
      }
    }

    before do
      xhr :post, :create, params, {}
    end

    describe 'レスポンスボディ' do
      subject { response.body }

      it { should eq('1102') }
    end

    describe 'session' do
      subject { session }

      describe '[:username]' do
        subject { super()[:username] }

        it { should eq(params[:username]) }
      end
    end
  end

  describe 'ログアウトする (DELETE destroy)' do
    let(:_session) {
      {
        username: '1102',
      }
    }

    before do
      xhr :delete, :destroy, {}, _session
    end

    describe 'session' do
      subject { session }

      describe '[:username]' do
        subject { super()[:username] }

        it { should be_nil }
      end
    end
  end
end

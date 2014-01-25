# -*- coding: utf-8 -*-
require 'spec_helper'

describe EditorHelper do
  describe '#toolbox_number_value' do
    subject { toolbox_number_value(name, value) }

    let(:name) { 'ANGLE' }
    let(:value) { 90 }

    it { should be_html_safe }
    it { should include(%(name="#{h name}")) }
    it { should include(%(<field name="NUM">#{h value.to_i}</field>)) }

    context '入力値の名前にタグを含む場合' do
      let(:name) { '"><script>alert("hello")</script><"' }

      it { should include(%(name="#{h name}")) }
    end

    shared_examples 'NUM is 0' do
      it { should include(%(<field name="NUM">0</field>)) }
    end

    context '数値に文字列を指定した場合' do
      let(:value) { 'invalid' }

      include_examples 'NUM is 0'
    end

    context '数値を指定しない場合' do
      subject { toolbox_number_value(name) }

      include_examples 'NUM is 0'
    end
  end
end

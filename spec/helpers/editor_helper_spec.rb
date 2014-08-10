# -*- coding: utf-8 -*-
require 'spec_helper'

describe EditorHelper do
  INCLUDED_HTML_STRING = '"><script>alert("hello")</script><"'

  shared_context 'name include html', name_include_html: true do
    let(:name) { INCLUDED_HTML_STRING }
  end

  describe '#toolbox_character_field' do
    subject { toolbox_character_field(name) }

    let(:name) { 'VAR' }

    it { should be_html_safe }
    it { should include(%(<field name="#{h name}">char1</field>)) }

    context '名前にタグを含む場合', name_include_html: true do
      it { should include(%(<field name="#{h name}">char1</field>)) }
    end
  end

  describe '#toolbox_key_field' do
    subject { toolbox_key_field(name, value) }

    let(:name) { 'KEY' }
    let(:value) { 'K_A' }

    it { should be_html_safe }
    it { should include(%(<field name="#{h name}">#{h value}</field>)) }

    context '名前にタグを含む場合', name_include_html: true do
      it { should include(%(<field name="#{h name}">#{h value}</field>)) }
    end

    context '値を省略した場合' do
      subject { toolbox_key_field(name) }

      it { should include(%(<field name="#{h name}">K_SPACE</field>)) }
    end

    context '名前と値を省略した場合' do
      subject { toolbox_key_field }

      it { should include('<field name="KEY">K_SPACE</field>') }
    end
  end

  describe '#toolbox_pin_field' do
    subject { toolbox_pin_field(value, name) }

    let(:name) { 'PIN' }
    let(:value) { 'D5' }

    it { should be_html_safe }
    it { should include(%(<field name="#{h name}">#{h value}</field>)) }

    context '名前にタグを含む場合', name_include_html: true do
      it { should include(%(<field name="#{h name}">#{h value}</field>)) }
    end

    context '名前を省略した場合' do
      subject { toolbox_pin_field(value) }

      it { should include(%(<field name="PIN">#{h value}</field>)) }
    end
  end

  describe '#toolbox_number_value' do
    subject { toolbox_number_value(name, value) }

    let(:name) { 'ANGLE' }
    let(:value) { 90 }

    it { should be_html_safe }
    it { should include(%(<value name="#{h name}">)) }
    it { should include(%(<field name="NUM">#{h value.to_i}</field>)) }

    context '入力値の名前にタグを含む場合', name_include_html: true do
      it { should include(%(<value name="#{h name}">)) }
    end

    shared_examples 'NUM is 0' do
      it { should include('<field name="NUM">0</field>') }
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

  describe '#toolbox_text_value' do
    subject { toolbox_text_value(name, value) }

    let(:name) { 'TEXT' }
    let(:value) { 'こんにちは！' }

    it { should be_html_safe }
    it { should include(%(<value name="#{h name}">)) }
    it { should include(%(<field name="TEXT">#{h value}</field>)) }

    context '入力値の名前にタグを含む場合', name_include_html: true do
      it { should include(%(<value name="#{h name}">)) }
    end

    context '文字列にタグを含む場合' do
      let(:value) { INCLUDED_HTML_STRING }

      it { should include(%(<field name="TEXT">#{h value}</field>)) }
    end

    context '入力値の名前と文字列を指定しない場合' do
      subject { toolbox_text_value }

      it { should include('<value name="TEXT">') }
      it { should include('<field name="TEXT"></field>') }
    end

    context '文字列を指定しない場合' do
      subject { toolbox_text_value(name) }

      it { should include('<field name="TEXT"></field>') }
    end
  end
end

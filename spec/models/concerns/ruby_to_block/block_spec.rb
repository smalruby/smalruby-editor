# -*- coding: utf-8 -*-
require 'spec_helper'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block do
  describe '.new' do
    subject { described_class.new(type) }

    context '引数がruby_statementの場合'do
      let(:type) { 'ruby_statement' }

      it { should be_instance_of(described_class::RubyStatement) }
    end
  end

  describe '.statement_regexp' do
    subject { described_class.statement_regexp }

    it { should be_kind_of(Regexp) }
    it {
      expect(subject.to_s)
        .to match(/#{Regexp.quote('|(?<ruby_statement>^.*$))')}$/)
    }
    its(:names) { should include('ruby_statement') }
  end

  describe '.value_regexp' do
    subject { described_class.value_regexp }

    it { should be_kind_of(Regexp) }
    it {
      expect(subject.to_s)
        .to match(/#{Regexp.quote('|(?<ruby_expression>^.*$))')}$/)
    }
    its(:names) { should include('ruby_expression') }
  end

  describe '.regexp' do
    subject { described_class.regexp(type) }

    context '引数がruby_statementの場合'do
      let(:type) { 'ruby_statement' }

      it { should be_kind_of(Regexp) }
      it { should eq(Regexp.new(described_class::RubyStatement.regexp)) }
    end
  end
end

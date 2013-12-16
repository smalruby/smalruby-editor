# -*- coding: utf-8 -*-
require 'spec_helper'

describe SourceCode, 'Rubyのソースコードを表現するモデル' do
  describe '#check_syntax', 'シンタックスをチェックする' do
    subject { source_code.check_syntax }

    context 'シンタックスが正しい場合' do
      let(:source_code) {
        SourceCode.new(data: <<-EOS.strip_heredoc)
          puts "Hello, World!"
        EOS
      }

      it { should be_empty }
    end

    context 'シンタックスが正しくない場合' do
      let(:source_code) {
        SourceCode.new(data: <<-EOS.strip_heredoc)
          puts Hello, World!"
        EOS
      }

      it { should_not be_empty }
      it {
        should include(row: 1, column: 0,
                       message: "syntax error, unexpected tSTRING_BEG, expecting keyword_do or '{' or '('")
      }
      it {should include(row: 1, column: 0, message: 'unterminated string meets end of file') }
    end
  end
end

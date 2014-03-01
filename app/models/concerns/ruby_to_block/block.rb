# -*- coding: utf-8 -*-

module RubyToBlock
  # ブロック群を表現するモジュール
  module Block
    @blocks = {}

    # ブロックのインスタンスを生成する
    def self.new(type, *args)
      @blocks[type].new(*args)
    end

    # ステートメントを表現するブロックの正規表現を返す
    def self.statement_regexp
      return @statement_regexp if @statement_regexp

      regexps = @blocks.values.select(&:statement?).sort_by(&:priority).reverse
        .map { |klass|
        "(?<#{klass.type}>#{klass.regexp_string})"
      }
      @statement_regexp = Regexp.new(regexps.join('|'), 'x')
    end

    # ブロックを登録する
    def self.register(klass)
      @blocks[klass.type] = klass
    end

    # ブロックの正規表現を返す
    def self.regexp(type)
      @blocks[type.to_s].regexp
    end

    # MatchDataを処理する
    def self.process_match_data(type, match_data, context)
      @blocks[type.to_s].process_match_data(match_data, context)
    end
  end
end

base_block = Pathname(__FILE__).dirname.join('block', 'base.rb')
require base_block.expand_path

block_pattern = Pathname(__FILE__).dirname.join('block', '*.rb')
block_files = Pathname.glob(block_pattern)
block_files.delete(base_block)
block_files.each do |path|
  require path.expand_path
end

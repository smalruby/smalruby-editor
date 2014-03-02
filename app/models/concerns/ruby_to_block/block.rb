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

    # 値を表現するブロックの正規表現を返す
    def self.value_regexp
      return @value_regexp if @value_regexp

      regexps = @blocks.values.select(&:value?).sort_by(&:priority).reverse
        .map { |klass|
        "(?<#{klass.type}>#{klass.regexp_string})"
      }
      @value_regexp = Regexp.new(regexps.join('|'), 'x')
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
    def self.process_match_data(md, context, type = nil)
      type = md.names.find { |n| md[n.to_sym] } unless type
      @blocks[type].process_match_data(md, context)
    end

    # endを処理する
    def self.process_end(context)
      s = context.statement
      @blocks[s.first].process_end(context)
    end

    # ブロックを表現するクラスを返す
    def self.[](type)
      @blocks[type.to_s]
    end
  end
end

preloads = ['base', 'value'].map { |s| "#{s}.rb"}
preloads.each do |preload|
  path = Pathname(__FILE__).dirname.join('block', preload)
  load path.expand_path
end

block_pattern = Pathname(__FILE__).dirname.join('block', '*.rb')
block_files = Pathname.glob(block_pattern)
block_files.each do |path|
  next if preloads.include?(path.basename)

  load path.expand_path
end

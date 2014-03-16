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
      @statement_regexp ||= make_regexp(:statement?)
    end

    # 値を表現するブロックの正規表現を返す
    def self.value_regexp
      @value_regexp ||= make_regexp(:value?)
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
    rescue
      false
    end

    # elseを処理する
    def self.process_else(context)
      st = context.statement
      @blocks[st.first].process_else(context)
    rescue
      false
    end

    # endを処理する
    def self.process_end(context)
      st = context.statement
      @blocks[st.first].process_end(context)
    rescue
      false
    end

    # ブロックを表現するクラスを返す
    def self.[](type)
      @blocks[type.to_s]
    end

    def self.make_regexp(method_symbol)
      regexps = @blocks.values.select(&method_symbol).sort_by(&:priority)
        .reverse.map { |klass|
        "(?<#{klass.type}>#{klass.regexp_string})"
      }
      Regexp.new(regexps.join('|'), 'x')
    end
    private_class_method :make_regexp
  end
end

preloads = %w(
  base
  value
  character_operation
  character_method_call
  character_event
).map { |s|
  "#{s}.rb"
}
preloads.each do |preload|
  path = Pathname(__FILE__).dirname.join('block', preload)
  silence_warnings do
    load path.expand_path
  end
end

block_pattern = Pathname(__FILE__).dirname.join('block', '*.rb')
block_files = Pathname.glob(block_pattern)
block_files.each do |path|
  next if preloads.include?(path.basename)

  silence_warnings do
    load path.expand_path
  end
end

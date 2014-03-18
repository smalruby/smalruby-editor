# -*- coding: utf-8 -*-

module RubyToBlock
  module Block
    # すべてのブロックのベースクラス
    class Base
      attr_accessor :parent
      attr_accessor :prev_sibling
      attr_accessor :sibling
      attr_accessor :fields
      attr_accessor :values
      attr_accessor :statements

      def self.inherited(child)
        Block.register(child)
      end

      def self.blocknize(regexp, options = {})
        klass = (class << self; self; end)
        klass.instance_eval do
          define_method(:regexp_string) do
            regexp
          end

          %w(
            statement
            value
            indent
            inline
            priority
          ).each do |name|
            sym = name.to_sym
            if options.key?(sym)
              v = options[sym]
              if v.is_a?(TrueClass) || v.is_a?(FalseClass)
                sym = "#{name}?".to_sym
              end
              define_method(sym) do
                v
              end
            end
          end
        end
      end

      def self.type
        name.sub('RubyToBlock::Block::', '').underscore
      end

      # 正規表現を返す
      def self.regexp
        @regexp ||= Regexp.new(regexp_string)
      end

      # ステートメントかどうかを返す
      #
      # trueの場合、Block.statement_regexpに追加される
      def self.statement?
        false
      end

      # 値かどうかを返す
      #
      # trueの場合、Block.value_regexpに追加される
      def self.value?
        false
      end

      # 正規表現の優先度を返す
      def self.priority
        0
      end

      # インデントする必要があるかどうかを返す
      def self.indent?
        false
      end

      # インラインのブロックかどうかを返す
      def self.inline?
        false
      end

      # 正規表現にマッチしたデータを解析する
      #
      # @return [true] これ以上解析する必要がない
      # @return [false] 解析できなかったのでさらなる解析が必要
      def self.process_match_data(md, context)
        true
      end

      # 値を格納した文字列を解析する
      #
      # @return [true] これ以上解析する必要がない
      # @return [false] 解析できなかったのでさらなる解析が必要
      def self.process_value_string(context, block, string, name)
        # HACK: 最初と最後の括弧を取り除く
        string = string[1..-2] while string[0] == '(' && string[-1] == ')'

        value_md = Block.value_regexp.match(string)
        return false unless value_md

        _current_block = context.current_block
        context.current_block = block
        context.value_name_stack.push(name)

        unless Block.process_match_data(value_md, context)
          Block.process_match_data(value_md, context, 'ruby_expression')
        end

        context.value_name_stack.pop
        context.current_block = _current_block

        true
      end

      # elseを発見した時の処理
      #
      # @return [true] これ以上処理する必要がない
      # @return [false] 処理できなかった
      def self.process_else(context)
        false
      end

      # endを発見した時の処理
      #
      # @return [true] これ以上処理する必要がない
      # @return [false] 処理できなかった
      def self.process_end(context)
        context.current_block = context.statement[1]
        context.statement_stack.pop

        true
      end

      def initialize(options = {})
        @fields = options[:fields] || {}
        @values = options[:values] || {}
        @statements = options[:statements] || {}

        if @statements.length > 0
          @statements.values.each do |s|
            s.parent = self
          end
        end
      end

      def to_xml(parent)
        e = parent.add_element('block', 'type' => type)
        e.add_attribute('inline', 'true') if inline?
        fields_to_xml(e)
        values_to_xml(e)
        statements_to_xml(e)
        sibling_to_xml(e)
        e
      end

      def type
        @type ||= self.class.type
      end

      def inline?
        @inline ||= self.class.inline?
      end

      def null?
        false
      end

      def [](name)
        @fields[name]
      end

      def add_statement(name, block)
        b = @statements[name]
        if b
          b = b.sibling while b.sibling
          b.sibling = block
        else
          block.parent = self
          @statements[name] = block
        end
        self
      end

      def add_value(name, block)
        b = @values[name]
        if b
          b = b.sibling while b.sibling
          b.sibling = block
        else
          block.parent = self
          @values[name] = block
        end
        self
      end

      def sibling=(block)
        block.parent = parent
        @sibling = block
        block.prev_sibling = self
      end

      def indent_level
        b = self
        level = 0
        while b.parent
          b = b.parent
          level += 1 if b.class.indent?
        end
        level
      end

      private

      def fields_to_xml(parent)
        @fields.each do |k, v|
          e = parent.add_element('field', 'name' => k.to_s)
          if v.is_a?(String)
            e.text = v
          else
            # TODO
          end
        end
      end

      def values_to_xml(parent)
        @values.each do |k, v|
          next if v.null?
          e = parent.add_element('value', 'name' => k.to_s)
          v.to_xml(e)
        end
      end

      def statements_to_xml(parent)
        @statements.each do |k, v|
          next if v.null?
          e = parent.add_element('statement', 'name' => k.to_s)
          v.to_xml(e)
        end
      end

      def sibling_to_xml(parent)
        return nil unless @sibling

        e = parent.add_element('next')
        @sibling.to_xml(e)
      end
    end
  end
end

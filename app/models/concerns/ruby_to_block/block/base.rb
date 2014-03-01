# -*- coding: utf-8 -*-

module RubyToBlock
  module Block
    # すべてのブロックのベースクラス
    class Base
      attr_accessor :parent
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

          if options.key?(:statement)
            statement = options[:statement]
            define_method(:statement?) do
              statement
            end
          end

          if options.key?(:priority)
            priority = options[:priority]
            define_method(:priority) do
              priority
            end
          end

          if options.key?(:indent)
            indent = options[:indent]
            define_method(:indent?) do
              indent
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

      # 正規表現の優先度を返す
      def self.priority
        0
      end

      # インデントする必要があるかどうかを返す
      def self.indent?
        false
      end

      # 正規表現にマッチしたデータを解析する
      #
      # @return [true] これ以上解析する必要がない
      # @return [false] 解析できなかったのでさらなる解析が必要
      def self.process_match_data(md, context)
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
        false
      end

      def null?
        false
      end

      def [](name)
        @fields[name]
      end

      def add_statement(name, block)
        b = @statements[name]
        b = b.sibling while b.sibling
        b.sibling = block
        nil
      end

      def sibling=(block)
        block.parent = parent
        @sibling = block
      end

      def indent_level
        b = self
        level = 0
        while b.parent
          level += 1 if b.class.indent?
          b = b.parent
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
          # TODO
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

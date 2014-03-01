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
        @type ||= self.class.name.sub('RubyToBlock::Block::', '').underscore
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
      end

      def sibling=(block)
        block.parent = self.parent
        @sibling = block
      end

      def indent?
        false
      end

      def indent_level
        b = self
        level = 0
        while b.parent
          level += 1 if b.indent?
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

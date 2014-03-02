# -*- coding: utf-8 -*-

module RubyToBlock
  # ソースコード解析の状態を表現するクラス
  class Context
    attr_accessor :lines
    attr_accessor :characters
    attr_accessor :character_stack
    attr_accessor :receiver_stack
    attr_accessor :statement_stack
    attr_accessor :blocks
    attr_accessor :current_block
    attr_accessor :statement_regexp_symbols

    def initialize(lines)
      @lines = lines
      @characters = {}
      @character_stack = []
      @receiver_stack = []
      @statement_stack = []
      @blocks = []
      @current_block = nil
      @statement_regexp_symbols = Block.statement_regexp.names.map(&:to_sym)
    end

    def next_line
      lines.shift
    end

    def add_block(block)
      if current_block
        current_block.sibling = block
      else
        blocks.push(block)
      end
      self.current_block = block
      self
    end

    def [](symbol)
      send(symbol)
    end

    def []=(symbol, val)
      send("#{symbol}=", val)
    end

    def receiver
      @receiver_stack.last
    end
  end
end

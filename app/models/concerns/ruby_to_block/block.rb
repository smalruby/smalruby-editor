# -*- coding: utf-8 -*-

module RubyToBlock
  # ブロック群を表現するモジュール
  module Block
    # ブロックのインスタンスを生成する
    def self.new(type, *args)
      const_get(type.camelize).new(*args)
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

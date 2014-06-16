# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    # キャラクターのメソッドや属性に共通するメソッドや定数を定義するモジュール
    module CharacterOperation
      extend ActiveSupport::Concern

      CHAR_NAME_RE = '([a-z]\S*)'
      CHAR_RE = '(?:' + CHAR_NAME_RE + '\.)?'

      attr_accessor :character

      module ClassMethods
        # コンテキストからキャラクターを取得する
        #
        # キャラクターの名前がnil、または'self'の場合はコンテキストのレシー
        # バの名前を利用する。
        #
        # コンテキストからキャラクターが取得できない場合は例外が発生する。
        #
        # @param [RubyToBlock::Context] context コンテキスト
        # @param [String] name キャラクターの名前
        # @return [Character] キャラクター
        def get_character(context, name)
          name = context.receiver.try(:name) if !name || name == 'self'
          fail unless context.characters.key?(name)
          context.characters[name]
        end

        # 必要であればcharacter_newブロックを作成してから指定したブロッ
        # クをcharacter_newブロックの子供として追加する
        #
        # @param [RubyToBlock::Context] context コンテキスト
        # @param [String] name キャラクターの名前
        # @param [ブロック] block ブロックのインスタンス
        # @return [Array<ブロック, ブロック>]
        #   最初の要素がcharacter_newブロック、次の要素がカレントブロックの配列
        def add_child_or_create_character_new_block(context, name, block)
          character = get_character(context, name)

          block.character = character

          cb = context.current_block
          if cb && cb.type == 'character_new' && cb.character == character
            cb.add_statement(:DO, block)
            [cb, cb]
          elsif character == context.receiver
            cb.sibling = block
            [cb.parent, block]
          else
            character_new =
              create_character_new_block(context, character, block)
            [character_new, character_new]
          end
        end

        # character_newブロックを生成する
        #
        # @param [RubyToBlock::Context] context コンテキスト
        # @param [RubyToBlock::Block::Character] character キャラクター
        # @param [RubyToBlock::Block::Baseのサブクラス] block ブロック
        # @return [RubyToBlock::Block::CharacterNew] character_newブロック
        def create_character_new_block(context, character, block)
          character_new_block = Block.new('character_new',
                                          fields: { NAME: character.name },
                                          statements: { DO: block })
          character_new_block.character = character

          cb = context.current_block
          if cb && cb.type != 'character_new'
            cb.sibling = character_new_block
          else
            context.blocks.push(character_new_block)
          end

          character_new_block
        end
      end
    end
  end
end

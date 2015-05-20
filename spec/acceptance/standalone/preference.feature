# encoding: utf-8
# language: en
@javascript
@standalone
Feature: Preference - 設定
  Background:
    When セッションをクリアする
    And '/' にアクセスする

  Scenario: ログインして設定ダイアログを表示する
    When "submenu-button" をクリックする

    Then "#submenu" に "#preference-button" が表示されていないこと

    When ログインする
    And "submenu-button" をクリックする

    Then "#submenu" に "#preference-button" が表示されていること

    When サブメニューの "#preference-button" をクリックする
    And JavaScriptによるアニメーションが終わるまで待つ

    Then "#preference-modal" が表示されていること

    When "preference-modal-ok-button" をクリックする
    And JavaScriptによるリクエストが終わるまで待つ

    Then "#preference-modal" が表示されていないこと

    When ログアウトする
    And "submenu-button" をクリックする

    Then "#submenu" に "#preference-button" が表示されていないこと

  Scenario: ツールボックス "通常" の設定を変更する
    When ログインする
    And サブメニューの "#preference-button" をクリックする

    Then "#preference-modal" が表示されていること
    And コンボボックス "user[preferences][toolbox_name]" の "通常" を選択していること
    And "#user_preferences_toolbox__default__enabled_hardware_blocks" が表示されていること
    And "user[preferences][toolbox__default__enabled_hardware_blocks]" がチェックされていないこと
    And "#user_preferences_toolbox__default__enabled_smalrubot_v3_blocks" が表示されていること
    And "user[preferences][toolbox__default__enabled_smalrubot_v3_blocks]" がチェックされていないこと
    And "#user_preferences_toolbox__default__enabled_smalrubot_s1_blocks" が表示されていること
    And "user[preferences][toolbox__default__enabled_smalrubot_s1_blocks]" がチェックされていないこと

    When "user[preferences][toolbox__default__enabled_hardware_blocks]" をチェックする
    And "user[preferences][toolbox__default__enabled_smalrubot_v3_blocks]" をチェックする
    And "user[preferences][toolbox__default__enabled_smalrubot_s1_blocks]" をチェックする
    And "preference-modal-ok-button" をクリックする
    And JavaScriptによるリクエストが終わるまで待つ

    Then "#preference-modal" が表示されていないこと

    When サブメニューの "#preference-button" をクリックする

    Then "#preference-modal" が表示されていること
    And コンボボックス "user[preferences][toolbox_name]" の "通常" を選択していること
    And "#user_preferences_toolbox__default__enabled_hardware_blocks" が表示されていること
    And "user[preferences][toolbox__default__enabled_hardware_blocks]" がチェックされていること
    And "#user_preferences_toolbox__default__enabled_smalrubot_v3_blocks" が表示されていること
    And "user[preferences][toolbox__default__enabled_smalrubot_v3_blocks]" がチェックされていること
    And "#user_preferences_toolbox__default__enabled_smalrubot_s1_blocks" が表示されていること
    And "user[preferences][toolbox__default__enabled_smalrubot_s1_blocks]" がチェックされていること

  Scenario: 一般設定を変更する
    When ログインする
    And サブメニューの "#preference-button" をクリックする

    Then "#preference-modal" が表示されていること
    And "user[preferences][disabled_add_character_from_beginning]" がチェックされていること
    And "user[preferences][disabled_new_character]" がチェックされていないこと
    And "user[preferences][enabled_readonly_ruby_mode]" がチェックされていないこと
    And "user[preferences][hardware_port]" フィールドの値が "" であること

    When "user[preferences][disabled_add_character_from_beginning]" のチェックを外す
    And "user[preferences][disabled_new_character]" をチェックする
    And "user[preferences][enabled_readonly_ruby_mode]" をチェックする
    And "user[preferences][hardware_port]" フィールドに "COM3" を指定する
    And "preference-modal-ok-button" をクリックする
    And JavaScriptによるリクエストが終わるまで待つ

    Then "#preference-modal" が表示されていないこと

    When サブメニューの "#preference-button" をクリックする

    Then "#preference-modal" が表示されていること
    And "user[preferences][disabled_add_character_from_beginning]" がチェックされていないこと
    And "user[preferences][disabled_new_character]" がチェックされていること
    And "user[preferences][enabled_readonly_ruby_mode]" がチェックされていること
    And "user[preferences][hardware_port]" フィールドの値が "COM3" であること

  Scenario: 「キャラクターの追加を禁止する」を設定後、ログアウトせずにリロードしてもキャラクターの追加ボタンを表示しないこと
    When ログインする
    And サブメニューの "#preference-button" をクリックする
    And "user[preferences][disabled_new_character]" をチェックする
    And "preference-modal-ok-button" をクリックする
    And JavaScriptによるリクエストが終わるまで待つ

    Then "#preference-modal" が表示されていないこと
    And "#add-character-item" が表示されていないこと

    When ページをリロードする

    And "#add-character-item" が表示されていないこと

  Scenario: 「プログラムを直接入力できないようにする」を設定後、ログアウトせずにリロードしてもRubyモードでプログラムを直接入力できないこと
    When ログインする
    And サブメニューの "#preference-button" をクリックする
    And "user[preferences][enabled_readonly_ruby_mode]" をチェックする
    And "preference-modal-ok-button" をクリックする
    And JavaScriptによるリクエストが終わるまで待つ

    Then "#preference-modal" が表示されていないこと
    And テキストエディタが編集できない状態であること

    When ページをリロードする

    Then テキストエディタが編集できない状態であること

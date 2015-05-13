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

    Then "#submenu" に "設定" を含まないこと

    When ログインする
    And "サブメニューボタン" をクリックする

    Then "#submenu" に "設定" を含むこと

    When ログアウトする
    And "submenu-button" をクリックする

    Then "#submenu" に "設定" を含まないこと

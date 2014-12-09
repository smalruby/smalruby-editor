# -*- coding: utf-8 -*-

module SmalrubyEditor
  # app/assets以下のJavaScriptからBlocklyのメッセージを扱いやすくするた
  # めのヘルパーモジュール
  module BlocklyMessageHelper
    def bm(name)
      if /\A\./ =~ name
        caller()[0] =~ /(.*?):(\d+)/
        filename, linenum = $1, $2
        prefix = filename.slice(%r"app/assets/javascripts/(.*)$", 1)
          .gsub(/\..*\z/, '')
        name = (prefix + name).gsub(%r"[/.]", '_')
      end
      "Smalruby.bm('#{name.upcase}')"
    end
  end
end

include SmalrubyEditor::BlocklyMessageHelper

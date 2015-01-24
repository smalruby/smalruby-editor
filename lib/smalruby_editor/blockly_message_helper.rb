# -*- coding: utf-8 -*-

module SmalrubyEditor
  # app/assets以下のJavaScriptからBlocklyのメッセージを扱いやすくするた
  # めのヘルパーモジュール
  module BlocklyMessageHelper
    def bm(name)
      if /\A\./ =~ name
        md = /(.*?):(?:\d+)/.match(caller[0])
        filename = md[1]
        prefix = filename.slice(%r"app/assets/javascripts/(.*)$", 1)
          .gsub(/\..*\z/, '')
        name = prefix + name
      end
      name = name.gsub(/[\/.]/, '_')
      "Smalruby.bm('#{name.upcase}')"
    end
  end
end

include SmalrubyEditor::BlocklyMessageHelper

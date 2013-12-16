# -*- coding: utf-8 -*-

require 'tempfile'
require 'open3'

# ソースコードを表現するモデル
class SourceCode < ActiveRecord::Base
  # シンタックスをチェックする
  def check_syntax
    tempfile = Tempfile.new('smalruby-editor')
    tempfile.write(self.data)
    path = tempfile.path
    tempfile.close
    stdout_str, stderr_str, status = *Open3.capture3("ruby -c #{path}")
    if status.success?
      return []
    end
    stderr_str.lines.map { |line|
      md = /^.*:(\d+): (.*)$/.match(line)
      { row: md[1].to_i, column: 0, message: md[2] }
    }
  end
end

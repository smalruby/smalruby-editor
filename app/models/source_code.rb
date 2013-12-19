# -*- coding: utf-8 -*-

require 'tempfile'
require 'open3'
require 'digest/sha2'

# ソースコードを表現するモデル
class SourceCode < ActiveRecord::Base
  validates :filename, presence: true
  validates :data, presence: true

  # シンタックスをチェックする
  def check_syntax
    _, stderr_str, status = *open3_capture3_ruby_c
    return [] if status.success?

    stderr_str.lines.each.with_object([]) { |line, res|
      if (md = /^.*:(\d+): (.*)$/.match(line))
        res << { row: md[1].to_i, column: 0, message: md[2] }
      elsif (md = /( +)\^$/.match(line))
        res[-1][:column] = md[1].length
      end
    }
  end

  # ハッシュ値を計算する
  def digest
    Digest::SHA256.hexdigest(data)
  end

  private

  def open3_capture3_ruby_c
    tempfile = Tempfile.new('smalruby-editor')
    tempfile.write(data)
    path = tempfile.path
    tempfile.close
    ruby_cmd = File.join(RbConfig::CONFIG['bindir'],
                         RbConfig::CONFIG['RUBY_INSTALL_NAME'])
    Open3.capture3("#{ruby_cmd} -c #{path}")
  end
end

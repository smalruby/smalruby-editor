# -*- coding: utf-8 -*-

require 'tempfile'
require 'open3'
require 'digest/sha2'
require 'bundler'
require 'smalruby_editor'
silence_warnings do
  require_relative 'concerns/ruby_to_block'
end

# ソースコードを表現するモデル
class SourceCode < ActiveRecord::Base
  include RubyToBlock

  validates :filename, presence: true
  validate :validate_filename
  validates :data, presence: true, allow_blank: true

  MAX_REMIX_COUNT = 1000

  # リミックス用のファイル名を生成する
  def self.make_remix_filename(home_dir, filename)
    home_dir = Pathname(home_dir).expand_path
    filename = filename.dup
    ext = filename.slice!(/\.rb(\.xml)?$/)
    filename.slice!(/(_remix(\d+)?)+$/)
    basename = "#{filename}_remix"
    MAX_REMIX_COUNT.times do |i|
      suffix = (i == 0 ? '' : sprintf('%02d', i + 1))
      remix_name = "#{basename}#{suffix}"
      if !home_dir.join("#{remix_name}.rb").exist? &&
          !home_dir.join("#{remix_name}.rb.xml").exist?
        return "#{remix_name}#{ext}"
      end
    end
    fail "reach max remix count...: #{filename}"
  end

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

  # プログラムを実行する
  def run(path)
    _, stderr_str, status = *open3_capture3_run_program(path)
    return [] if status.success?

    parse_ruby_error_messages(stderr_str)
  end

  # ハッシュ値を計算する
  def digest
    Digest::SHA256.hexdigest(data)
  end

  # ソースコードの概要を取得する
  def summary
    res = {}
    if xml?
      res[:filename] = filename.sub(/\.xml\z/, '')

      doc = Nokogiri::HTML.parse(data)
      if (attr = doc.xpath('//character[1]/@costumes').first)
        res[:imageUrl] = "/smalruby/assets/#{attr.value}"
      end
      text = doc.xpath('//block[@type="ruby_comment"][1]' +
                       '/field[@name="COMMENT"]/text()').first
      res[:title] = text.to_s if text
    else
      res[:filename] = filename
    end
    res[:title] = filename unless res[:title]
    res
  end

  # 指定した命令ブロックを含んでいるかどうかを返す
  #
  # @param [String|Regexp] type 命令ブロックの種類
  # @return [Boolean] 命令ブロックを含む場合はtrue、そうでない場合はfalse
  def include_block?(type)
    if xml?
      doc = Nokogiri::HTML.parse(data)
      if type.is_a?(Regexp)
        doc.xpath(%(//block[matches(@type, '#{type.source}')]),
                  MatchesXPathFunction.new).length > 0
      else
        doc.xpath(%(//block[@type="#{type}"])).length > 0
      end
    else
      false
    end
  end

  # ソースコードの種別がXML形式かどうかを返す
  def xml?
    !!(/\.xml\z/ =~ filename)
  end

  private

  class MatchesXPathFunction
    def matches(node_set, regex)
      node_set.select { |node|
        node.value =~ /#{regex}/
      }
    end
  end

  private_constant :MatchesXPathFunction

  def validate_filename
    if File.basename(filename) != filename
      errors.add(:filename, 'includes directory separator(s)')
    end
  end

  def ruby_cmd
    if SmalrubyEditor.osx?
      Pathname(Gem.bin_path('rsdl', 'rsdl'))
    else
      Pathname(RbConfig::CONFIG['RUBY_INSTALL_NAME'])
        .expand_path(RbConfig::CONFIG['bindir'])
    end
  end

  def open3_capture3_ruby_c
    tempfile = Tempfile.new('smalruby-editor')
    tempfile.write(data)
    path = tempfile.path
    tempfile.close

    Bundler.with_clean_env do
      Open3.capture3("#{ruby_cmd} -c #{path}")
    end
  end

  def open3_capture3_run_program(path)
    Bundler.with_clean_env do
      Open3.capture3("#{ruby_cmd} #{path}")
    end
  end

  def parse_ruby_error_messages(stderr_str)
    stderr_str.lines.each.with_object([]) { |line, res|
      if (md = /^\tfrom .*:(\d+):(in .*)$/.match(line))
        res << { row: md[1].to_i, column: 0, message: md[2] }
      elsif (md = /^.*:(\d+):(in .*)$/.match(line))
        res << { row: md[1].to_i, column: 0, message: md[2] }
      elsif (md = /( +)\^$/.match(line))
        res[-1][:column] = md[1].length
      else
        row = res[-1] ? res[-1][:row] : 0
        res << { row: row, column: 0, message: line.chomp }
      end
    }
  end
end

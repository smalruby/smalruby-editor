# -*- coding: utf-8 -*-
# Doc Stringsに含まれるシナリオアウトラインのプレースホルダを置き換える
# ためのモンキーパッチ。turnip-1.1.0で動作確認済み。
# rubocop:disable all
class Turnip::Builder
  class ScenarioOutline
    def to_scenarios(examples)
      rows = examples.rows.map(&:cells)
      headers = rows.shift
      rows.map do |row|
        Scenario.new(@raw).tap do |scenario|
          scenario.steps = steps.map do |step|
            new_description = substitute(step.description, headers, row)
            new_extra_args = step.extra_args.map do |ea|
              if ea.instance_of?(Turnip::Table)
                Turnip::Table.new(ea.map {|t_row| t_row.map {|t_col| substitute(t_col, headers, row) } })
              else
                substitute_only_matched(ea, headers, row)
              end
            end
            Step.new(new_description, new_extra_args, step.line)
          end
        end
      end
    end

    private

    def substitute_only_matched(text, headers, row)
      text.gsub(/<([^<>]*)>/) { |s|
        (res = Hash[headers.zip(row)][$1]) ? res : s
      }
    end
  end
end

# HACK: RSpecのフォーマットがdocumentationの場合にTurnipの実行経過を出
#   力する。Cucumberのようにしたいがstepの定義場所は取得できないため、
#   featureの行番号を表示している。
module Turnip::RSpec::Execute
  def run_step_with_progress(feature_file, step)
    require 'rspec/core/formatters/documentation_formatter'
    if formatter.is_a?(RSpec::Core::Formatters::DocumentationFormatter)
      output.print "    #{step.description} # #{feature_file.sub(/^#{Regexp.quote(Rails.root.to_s.sub(/^(\S)/) { |s| s.downcase } + '/')}/, '')}:#{step.line}"
      s = Time.now
      run_step_without_progress(feature_file, step)
      elapsed = Time.now - s
      output.puts " (#{elapsed} sec)"
    else
      run_step_without_progress(feature_file, step)
    end
  end
  alias_method :run_step_without_progress, :run_step
  alias_method :run_step, :run_step_with_progress

  def formatter
    @formatter ||= RSpec.configuration.formatters.first
  end

  def output
    @output ||= formatter.output
  end
end

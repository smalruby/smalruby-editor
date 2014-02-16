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

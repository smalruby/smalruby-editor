shared_context ':to_blocks', to_blocks: true do
  let(:source_code) { SourceCode.new(data: data) }

  subject { source_code.to_blocks }
end

shared_context ':character_new_data', character_new_data: true do
  let(:data) {
    <<-EOS.strip_heredoc
require "smalruby"

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
#{parts}
    EOS
  }
end

shared_context ':on_start_data', on_start_data: true do
  let(:data) {
    <<-EOS.strip_heredoc
require "smalruby"

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

car1.on(:start) do
  #{parts.lines.join('  ')}
end
    EOS
  }
end

class EqBlockXml < RSpec::Matchers::BuiltIn::Eq
  def matches?(actual)
    indent = @expected.slice(/\A(\s*).*$/, 1).length
    re = /\A {#{indent},}/
    @actual = actual.lines.select { |l| re.match(l) }.join
    @actual = actual if @actual.empty?
    match(@expected, @actual)
  end
end

def eq_block_xml(xml)
  EqBlockXml.new(xml)
end

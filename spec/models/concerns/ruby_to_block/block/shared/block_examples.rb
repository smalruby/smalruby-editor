shared_context ':to_blocks', to_blocks: true do
  let(:source_code) { SourceCode.new(data: data) }

  subject { source_code.to_blocks }
end

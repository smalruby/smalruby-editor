module RubyToBlock
  module Block
    class RequireSmalruby < Base
      blocknize '^\s*require\s*"smalruby"\s*$', statement: true
    end
  end
end

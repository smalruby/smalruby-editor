module RubyToBlock
  module Block
    class RequireSmalruby < Base
      blocknize '^require\ "smalruby"$', statement: true
    end
  end
end

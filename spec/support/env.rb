# -*- coding: utf-8 -*-

require 'tmpdir'

# Rails.envをstandaloneにする
shared_context 'set standalone rails env', set_standalone_rails_env: true do
  before do
    @_rails_env = Rails.env
    Rails.env = ENV['RAILS_ENV'] = 'standalone'
  end

  after do
    Rails.env = ENV['RAILS_ENV'] = @_rails_env
  end
end

# プラットフォームをWindowsにする
shared_context 'set linux platform', set_linux_platform: true do
  before do
    stub_const('Platform::OS', :unix)
    stub_const('Platform::IMPL', :linux)
  end
end

# プラットフォームをMac OS Xにする
shared_context 'set macosx platform', set_macosx_platform: true do
  before do
    stub_const('Platform::OS', :unix)
    stub_const('Platform::IMPL', :macosx)
  end
end

# プラットフォームをWindowsにする
shared_context 'set windows platform', set_windows_platform: true do
  before do
    stub_const('Platform::OS', :win32)
    stub_const('Platform::IMPL', :mingw)
  end
end

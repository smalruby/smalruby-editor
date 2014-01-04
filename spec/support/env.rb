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

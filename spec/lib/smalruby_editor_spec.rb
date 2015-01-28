# -*- coding: utf-8 -*-
require_relative '../spec_helper'
require 'smalruby_editor'

describe SmalrubyEditor do
  describe '.create_home_directory' do
    before(:all) do
      @home_dir = Pathname(Dir.tmpdir).join('.smalruby-editor')
    end

    shared_examples 'ホームディレクトリを作成する', create_home_directory: true do
      after(:all) do
        FileUtils.rm_rf(@home_dir)
      end

      it 'ホームディレクトリを作成する' do
        expect(@home_dir).to be_directory
      end

      describe 'ホームディレクトリ' do
        %w(config db log tmp
           tmp/cache tmp/pids tmp/sessions tmp/sockets).each do |dir|
          it "#{dir}ディレクトリを作成する" do
            expect(@home_dir.join(dir)).to be_directory
          end
        end

        describe 'configディレクトリ' do
          describe 'config.yml' do
            let(:path) { @home_dir.join('config', 'config.yml') }

            it 'config.ymlを作成する' do
              expect(path).to be_exist
            end
          end

          describe 'database.yml' do
            let(:path) { @home_dir.join('config', 'database.yml') }

            it 'database.ymlを作成する' do
              expect(path).to be_exist
            end

            it 'database.ymlの内容が正しい' do
              expect(path.read).to eq(<<-EOS.strip_heredoc)
                standalone:
                  adapter: sqlite3
                  database: #{@home_dir.join('db', 'standalone.sqlite3')}
                  pool: 5
                  timeout: 5000
              EOS
            end
          end
        end
      end
    end

    it '戻り値は作成したホームディレクトリである' do
      expect(SmalrubyEditor.create_home_directory(@home_dir)).to eq(@home_dir)
    end

    context '引数を指定した場合', create_home_directory: true do
      before(:all) do
        SmalrubyEditor.create_home_directory(@home_dir)
      end
    end

    describe '引数を指定しない場合は環境変数SMALRUBY_EDITOR_HOMEに従う',
             create_home_directory: true do
      before(:all) do
        ENV['SMALRUBY_EDITOR_HOME'] = @home_dir.to_s
        SmalrubyEditor.create_home_directory
      end
    end

    context 'database.ymlが存在する場合', create_home_directory: true do
      before(:all) do
        database_yml_path = @home_dir.join('config', 'database.yml')
        FileUtils.mkdir_p(database_yml_path.dirname)
        database_yml_path.open('w') do |f|
          f.write('exist YAML')
        end

        SmalrubyEditor.create_home_directory(@home_dir)
      end
    end
  end
end

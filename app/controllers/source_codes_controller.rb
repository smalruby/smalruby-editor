# -*- coding: utf-8 -*-
require 'nkf'

class SourceCodesController < ApplicationController
  before_filter :check_whether_standalone, only: [:write, :run, :load_local]

  def index
    res = {
      localPrograms: [],
      demoPrograms: [],
    }

    select_and_get_summary = proc { |path|
      s = SourceCode.new(filename: path.basename.to_s, data: path.read)
      next if raspberrypi? && s.include_block?(/^(hardware_|pen_)/)
      s.summary
    }

    if standalone?
      res[:localPrograms] =
        local_program_paths.map(&select_and_get_summary).compact
    end

    res[:demoPrograms] =
      demo_program_paths.map(&select_and_get_summary).compact

    render json: res
  end

  def check
    render json: SourceCode.new(source_code_params).check_syntax
  end

  def create
    sc = SourceCode.create!(source_code_params)
    session[:source_code] = {
      id: sc.id,
      digest: sc.digest,
    }
    render json: { source_code: { id: sc.id } }
  end

  def download
    send_data(source_code.data,
              filename: url_encode_filename(source_code.filename),
              disposition: 'attachment',
              type: 'text/plain; charset=utf-8')

    destroy_source_code_and_delete_session(source_code)
  end

  def write
    res = { source_code: { filename: source_code.filename } }

    write_source_code(source_code)

    destroy_source_code_and_delete_session(source_code)

    render json: res
  rescue => e
    res[:source_code][:error] = e.message
    render json: res
  end

  def load
    f = params[:source_code][:file]
    info = get_file_info(f)
    if /\Atext\/plain/ =~ info[:type]
      info[:data] = NKF.nkf('-w', f.read)
    else
      info[:error] = I18n.t('.not_ruby_program',
                            scope: 'controllers.source_codes')
    end

    render json: { source_code: info }, content_type: request.format
  end

  def load_local
    filename = source_code_params[:filename]
    program_path = local_program_paths.find { |path|
      rb_basename(path) == filename
    }
    load_local_file(program_path, source_code_params[:remix])
  end

  def load_demo
    filename = source_code_params[:filename]
    program_path = demo_program_paths.find { |path|
      rb_basename(path) == filename
    }
    load_local_file(program_path, source_code_params[:remix])
  end

  def run
    source_code = SourceCode.new(source_code_params)
    if session[:username]
      s = "~/#{session[:username]}/#{source_code.filename}"
    else
      s = "~/#{source_code.filename}"
    end
    path = Pathname(s).expand_path
    render json: source_code.run(path)
  end

  def to_blocks
    source_code = SourceCode.new(source_code_params)
    render text: source_code.to_blocks
  rescue
    if Rails.env == 'development'
      raise
    else
      head :bad_request
    end
  end

  private

  def source_code_params
    params.require(:source_code).permit(:data, :filename, :remix)
  end

  def get_file_info(file)
    {
      filename: file.original_filename,
      type: MIME.check(file.path).try(:content_type) || file.content_type,
      size: file.size,
    }
  end

  def url_encode_filename(filename)
    if request.env['HTTP_USER_AGENT'] =~ /MSIE|Trident/
      return ERB::Util.url_encode(filename)
    else
      filename
    end
  end

  def source_code
    return @source_code if @source_code
    sc = SourceCode.find(session[:source_code][:id])
    unless sc.digest == session[:source_code][:digest]
      fail ActiveRecord::RecordNotFound
    end
    @source_code = sc
  end

  def write_source_code(source_code)
    if session[:username]
      s = "~/#{session[:username]}/#{source_code.filename}"
    else
      s = "~/#{source_code.filename}"
    end
    path = Pathname(s).expand_path.to_s

    if File.exist?(path) && params[:force].blank?
      fail I18n.t('.exist', scope: 'controllers.source_codes')
    end

    FileUtils.mkdir_p(File.dirname(path))
    File.open(path, 'w') do |f|
      f.write(source_code.data)
    end
  end

  def destroy_source_code_and_delete_session(source_code)
    source_code.destroy

    session[:source_code] = nil
  end

  def local_program_paths
    if session[:username]
      # TODO: session[:username]の/や\をエスケープする
      s = "~/#{session[:username]}/*.rb.xml"
    else
      s = '~/*.rb.xml'
    end
    Pathname.glob(Pathname(s).expand_path)
  end

  def demo_program_paths
    Pathname.glob(Rails.root.join('demos/*.rb.xml')) +
      Pathname.glob(SmalrubyEditor.home_directory.join('demos/*.rb.xml'))
  end

  def rb_basename(path)
    path = path.basename.to_s
    path = path[0...-4] if /\.xml\z/ =~ path
    path
  end

  def load_local_file(path, remix)
    if path
      if remix == 'true'
        filename = SourceCode.make_remix_filename("~/#{session[:username]}",
                                                  path.basename.to_s)
      else
        filename = path.basename.to_s
      end
      info = {
        filename: filename,
        type: MIME.check(path.to_s).try(:content_type) || 'text/plain',
        data: NKF.nkf('-w', path.read),
        size: path.size,
      }
    else
      info = {
        filename: source_code_params[:filename],
        error: I18n.t('.not_exist', scope: 'controllers.source_codes'),
      }
    end

    render json: { source_code: info }, content_type: request.format
  end
end

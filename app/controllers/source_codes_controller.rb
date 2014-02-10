# -*- coding: utf-8 -*-
require 'nkf'

class SourceCodesController < ApplicationController
  before_filter :check_whether_standalone, only: [:write, :run]

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
      info[:error] = 'Rubyのプログラムではありません'
    end

    render json: { source_code: info }, content_type: request.format
  end

  def run
    source_code = SourceCode.new(source_code_params)
    render json: source_code.run(Pathname("~/#{source_code.filename}").expand_path)
  end

  private

  def check_whether_standalone
    unless standalone?
      fail "#{self.class.name}##{action_name}はstandaloneモードのみの機能です"
    end
  end

  def source_code_params
    params.require(:source_code).permit(:data, :filename)
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
    path = Pathname("~/#{source_code.filename}").expand_path.to_s

    fail 'すでに同じ名前のプログラムがあります' if File.exist?(path) && params[:force].blank?

    File.open(path, 'w') do |f|
      f.write(source_code.data)
    end
  end

  def destroy_source_code_and_delete_session(source_code)
    source_code.destroy

    session[:source_code] = nil
  end
end

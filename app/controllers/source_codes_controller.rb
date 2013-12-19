# -*- coding: utf-8 -*-
require 'nkf'

class SourceCodesController < ApplicationController
  def check
    render json: SourceCode.new(source_code_params).check_syntax
  end

  def create
    source_code = SourceCode.create!(source_code_params)
    session[:source_code] = {
      id: source_code.id,
      digest: source_code.digest,
    }
    render json: { source_code: { id: source_code.id } }
  end

  def download
    source_code = SourceCode.find(session[:source_code][:id])
    unless source_code.digest == session[:source_code][:digest]
      fail ActiveRecord::RecordNotFound
    end

    send_data(source_code.data,
              filename: source_code.filename,
              disposition: 'attachment',
              type: 'text/plain; charset=utf-8')

    source_code.destroy

    session[:source_code] = nil
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

  private

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
end

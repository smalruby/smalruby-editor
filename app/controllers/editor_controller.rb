# -*- coding: utf-8 -*-
require 'nkf'

class EditorController < ApplicationController
  def index
  end

  def check
    render json: SourceCode.new(source_code_params).check_syntax
  end

  def save_file
    send_data(params[:source],
              filename: params[:filename],
              disposition: 'attachment',
              type: 'text/plain; charset=utf-8')
  end

  def load_file
    res = get_file_info(params['load_file'])
    if /\Atext\/plain/ =~ res[:type]
      res[:source] = NKF.nkf('-w', params['load_file'].read)
    else
      res[:error] = 'Rubyのプログラムではありません'
    end
    render json: res, content_type: request.format
  end

  private

  def source_code_params
    params.require(:source_code).permit(:data)
  end

  def get_file_info(file)
    {
      name: file.original_filename,
      type: MIME.check(file.path).try(:content_type) || file.content_type,
      size: file.size,
    }
  end
end

# -*- coding: utf-8 -*-
require 'nkf'

class EditorController < ApplicationController
  def index
  end

  def check
    render json: SourceCode.new(source_code_params).check_syntax
  end

  def save_file
    send_data(params[:source], filename: params[:filename],
              disposition: 'attachment', type: 'text/plain; charset=utf-8')
  end

  def load_file
    f = params['load_file']
    mime_type = MIME.check(f.path)
    content_type = mime_type.try(:content_type) || f.content_type
    res = {
      name: f.original_filename,
      type: content_type,
      size: f.size,
    }
    if /\Atext\/plain/ =~ content_type
      res[:source] = NKF.nkf('-w', f.read)
    else
      res[:error] = 'Rubyのプログラムではありません'
    end
    render json: res, content_type: request.format
  end

  private

  def source_code_params
    params.require(:source_code).permit(:data)
  end
end

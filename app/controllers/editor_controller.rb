# -*- coding: utf-8 -*-
require 'nkf'

class EditorController < ApplicationController
  def index
  end

  def check
    render json: SourceCode.new(source_code_params).check_syntax
  end

  def save_file
    source_code = SourceCode.create!(source_code_params)
    session[:source_code] = {
      id: source_code.id,
      hash: source_code.digest,
    }
    render nothing: true
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
    params.require(:source_code).permit(:data, :filename)
  end

  def get_file_info(file)
    {
      name: file.original_filename,
      type: MIME.check(file.path).try(:content_type) || file.content_type,
      size: file.size,
    }
  end
end

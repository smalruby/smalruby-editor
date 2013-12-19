# -*- coding: utf-8 -*-
require 'nkf'

class EditorController < ApplicationController
  def index
  end

  def destroy_file
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

  def get_file_info(file)
    {
      name: file.original_filename,
      type: MIME.check(file.path).try(:content_type) || file.content_type,
      size: file.size,
    }
  end
end

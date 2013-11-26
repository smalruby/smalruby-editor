require 'nkf'

class EditorController < ApplicationController
  def index
  end

  def save_file
    send_data(params[:source], filename: params[:filename],
              disposition: 'attachment', type: 'text/plain; charset=utf-8')
  end

  def load_file
    f = params['load_file']
    res = {
      name: f.original_filename,
      type: f.content_type,
      size: f.size,
      source: NKF.nkf('-w', f.read),
    }
    render json: res, content_type: request.format
  end
end

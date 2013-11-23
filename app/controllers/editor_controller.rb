class EditorController < ApplicationController
  def index
  end

  def save
    send_data(params[:source], filename: params[:filename],
              disposition: 'attachment', type: 'text/plain; charset=utf-8')
  end
end

# -*- coding: utf-8 -*-

class SourceCodesController < ApplicationController
  def create
    source_code = SourceCode.create!(source_code_params)
    session[:source_code] = {
      id: source_code.id,
      digest: source_code.digest,
    }
    render json: { source_code: { id: source_code.id } }
  end

  private

  def source_code_params
    params.require(:source_code).permit(:data, :filename)
  end
end

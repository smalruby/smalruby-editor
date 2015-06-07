# -*- coding: utf-8 -*-
class EditorController < ApplicationController
  def index
  end

  def demo
    @filename = (File.basename(params[:filename]) || 'car_chase') + '.rb.xml'
  end

  def costumes
    render layout: false
  end

  def toolbox
    render :toolbox, layout: false
  end
end

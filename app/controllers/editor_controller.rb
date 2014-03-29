# -*- coding: utf-8 -*-
class EditorController < ApplicationController
  def index
  end

  def demo
    @filename = (File.basename(params[:filename]) || 'default') + '.rb.xml'
  end
end

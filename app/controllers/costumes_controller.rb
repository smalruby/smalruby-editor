class CostumesController < ApplicationController
  layout false

  def index
    if signed_in?
      @costumes = current_user.costumes.with_preset
    else
      @costumes = Costume.presets
    end
    @costumes = @costumes.merge(Costume.default_order)
  end
end

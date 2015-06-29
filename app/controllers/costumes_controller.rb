class CostumesController < ApplicationController
  layout false

  before_filter :check_whether_standalone, only: [:show, :create, :destroy]

  def index
    if signed_in?
      @costumes = current_user.costumes.with_preset
    else
      @costumes = Costume.presets
    end
    @costumes = @costumes.merge(Costume.default_order)
  end

  def show
    name = params[:basename].sub(/\.png$/, "")
    costume = current_user.costumes.where(name: name).first
    send_file costume.path,
              type: "image/png", disposition: "inline", x_send_file: true
  end

  def create
    max_position =
      current_user.costumes.order(position: :desc).first.try(:position) || -1
    attrs = {
      basename: costume_params[:file].original_filename,
      preset: false,
      position: max_position + 1,
    }
    costume = current_user.costumes.create!(attrs)

    path = costume.path
    FileUtils.mkdir_p(path.dirname)
    File.open(path, "wb") do |f|
      f.write(costume_params[:file].read)
    end

    index

    render action: "index"
  end

  def destroy
    costume = current_user.costumes.where(id: params[:id]).first
    FileUtils.rm_f(costume.path)
    costume.destroy

    index

    render action: "index"
  end

  private

  def costume_params
    params.require(:costume).permit(:file)
  end
end

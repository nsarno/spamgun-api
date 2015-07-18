class SourcesController < ApplicationController
  before_action :authenticate

  def index
    render json: Source.all
  end

  def show
    render json: source
  end

  def create
    save_and_render Source.new(source_params), status: :created
  end

  def update
    save_and_render source, source_params_update
  end

  def destroy
    source.destroy
    head :no_content
  end

private
  def source
    @source ||= Source.find params[:id]
  end

  def update_permitted_params
    [
      :title, :form_url, :form_name, :form_email, :form_phone, :form_body,
      :form_cc, :page_param, :page_start, :page_max, :spam_max
    ]
  end

  def create_permitted_params
    update_permitted_params + [:list_url]
  end

  def source_params
    params.require(:source).permit create_permitted_params
  end

  def source_params_update
    params.require(:source).permit update_permitted_params
  end
end

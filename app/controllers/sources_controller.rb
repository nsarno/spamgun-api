class SourcesController < ApplicationController
  before_action :authenticate
  before_action :set_source, only: [:show, :update, :destroy]

  # GET /sources
  # GET /sources.json
  def index
    @sources = Source.all

    render json: @sources
  end

  # GET /sources/1
  # GET /sources/1.json
  def show
    render json: @source
  end

  # POST /sources
  # POST /sources.json
  def create
    @source = Source.new(source_params)

    if @source.save
      render json: @source, status: :created, location: @source
    else
      render json: @source.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sources/1
  # PATCH/PUT /sources/1.json
  def update
    @source = Source.find(params[:id])

    if @source.update(source_params_update)
      head :no_content
    else
      render json: @source.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sources/1
  # DELETE /sources/1.json
  def destroy
    @source.destroy

    head :no_content
  end

  private

    def set_source
      @source = Source.find(params[:id])
    end

    def source_params
      params.require(:source).permit(
        :title,
        :list_url, :form_url, :form_name, :form_email,
        :form_phone, :form_body, :form_cc,
        :page_param, :page_start, :page_max,
        :spam_max
      )
    end

    def source_params_update
      params.require(:source).permit(
        :title,
        :form_url, :form_name, :form_email,
        :form_phone, :form_body, :form_cc,
        :page_param, :page_start, :page_max,
        :spam_max
      )
    end
end

class JobsController < ApplicationController
  before_action :set_job, only: [:show]
  before_action :set_source, only: [:create]

  # GET /sources/1
  # GET /sources/1.json
  def show
    render json: @job
  end


  # POST /jobs
  # POST /jobs.json
  def create
    @job = @source.jobs.new(job_params)

    if @job.save
      render json: @job, status: :created, location: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  private

    def set_job
      @job = Job.find(params[:id])
    end

    def set_source
      @source = Source.find(job_params[:source_id])
    end

    def job_params
      params.require(:job).permit(:name, :source_id)
    end
end

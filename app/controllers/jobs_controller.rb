class JobsController < ApplicationController
  before_action :authenticate

  def show
    render json: job
  end

  def create
    save_and_render source.jobs.new(job_params), status: :created
  end

private

  def job
    Job.find params[:id]
  end

  def source
    Source.find job_params[:source_id]
  end

  def job_params
    params.require(:job).permit(:name, :source_id)
  end
end

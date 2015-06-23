require 'test_helper'

class JobsControllerTest < ActionController::TestCase
  setup do
    @job = jobs(:scrapper)
  end

  test "should create job" do
    assert_difference('Job.count') do
      post :create, job: { status: @job.status, name: @job.name, source_id: @job.source_id }
    end

    assert_response 201
  end

  test "should show source" do
    get :show, id: @job
    assert_response :success
  end
end

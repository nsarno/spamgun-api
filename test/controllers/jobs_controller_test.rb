require 'test_helper'

class JobsControllerTest < ActionController::TestCase
  setup do
    @job = jobs(:scrapper)
  end

  test "should create job" do
    # Don't assert difference, creating a job clean up the previous ones
    post :create, job: { status: @job.status, name: @job.name, source_id: @job.source_id }

    assert_response 201
  end

  test "should show source" do
    get :show, id: @job
    assert_response :success
  end
end

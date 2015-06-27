require 'test_helper'

class JobsControllerTest < ActionController::TestCase
  setup do
    @job = jobs(:scrapper)
  end

  test "should create job" do
    post :create, job: { status: @job.status, name: @job.name, source_id: @job.source_id }
    assert_response 201
  end
end

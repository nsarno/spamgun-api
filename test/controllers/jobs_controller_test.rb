require 'test_helper'

class JobsControllerTest < ActionController::TestCase
  setup do
    @job = jobs(:scrapper)
  end

  test "reponds with created status" do
    post :create, job: { status: @job.status, name: @job.name, source_id: @job.source_id }
    assert_response :created
  end
end

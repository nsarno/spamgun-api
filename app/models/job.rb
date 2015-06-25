class Job < ActiveRecord::Base
  enum status: [:pending, :running, :completed]

  belongs_to :source

  before_create :clear
  after_create :run

  JOB_TYPES = {
    'scrapper'  => 'ScrapperJob',
    'spammer'   => 'SpammerJob'
  }

  def clear
    self.source.jobs.delete_all
  end

  def run
    JOB_TYPES[self.name].constantize.perform_later self
  end
end

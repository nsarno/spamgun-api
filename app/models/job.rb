class Job < ActiveRecord::Base
  enum status: [:pending, :running, :completed]

  belongs_to :source

  after_create :run

  JOB_TYPES = { 
    'scrapper'  => 'ScrapperJob',
    'spammer'   => 'SpammerJob'
  }

  def run
    JOB_TYPES[self.name].constantize.perform_later self, 0
  end
end

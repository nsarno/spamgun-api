class Source < ActiveRecord::Base
  has_many :ads, dependent: :destroy
  has_many :jobs, dependent: :destroy

  validates_presence_of :list_url, :form_url, :form_name, :form_email, :form_body

  def scrap max_page=1
    agent = Mechanize.new
    page = Page.new agent.get(self.list_url)
    begin
      self.ads.create(page.ads)
    end while (page.next! && (page.no <= max_page || max_page.zero?))
  end

  def pending_count
    self.ads.where(status: Ad.statuses[:pending]).count
  end

  def replied_count
    self.ads.where(status: Ad.statuses[:completed]).count
  end

  def scrapping?
    self.jobs.where(name: 'scrapper', status: Job.statuses[:running]).any?
  end

  def spamming?
    self.jobs.where(name: 'spammer', status: Job.statuses[:running]).any?
  end

  def scrap_pending?
    self.jobs.where(name: 'scrapper', status: Job.statuses[:pending]).any?
  end

  def spam_pending?
    self.jobs.where(name: 'spammer', status: Job.statuses[:pending]).any?
  end

  def processing?
    scrapping? || spamming? || scrap_pending? || spam_pending?
  end
end

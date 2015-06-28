require 'uri'

class URI::HTTP
  def with_param param_name, param_value
    params = URI.decode_www_form(self.query || []) << [param_name, param_value]
    self.query = URI.encode_www_form(params)
    self
  end
end

class Source < ActiveRecord::Base
  has_many :ads, dependent: :destroy
  has_many :jobs, dependent: :destroy

  validates_presence_of :list_url, :form_url, :form_name, :form_email, :form_body

  def scrap
    agent = Mechanize.new
    start_url = URI(self.list_url).with_param(self.page_param, self.page_start).to_s
    pp start_url
    page = Page.new agent.get(start_url), self.page_start
    begin
      self.ads.create(page.ads)
    end while (page.next! && (page.no <= self.page_max || self.page_max.zero?))
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

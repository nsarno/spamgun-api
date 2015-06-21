class Source < ActiveRecord::Base
  has_many :ads

  validates_presence_of :list_url, :form_url, :form_name, :form_email, :form_body

  def scrap max_page=1
    agent = Mechanize.new
    page = Page.new agent.get(self.list_url)
    begin
      self.ads.create(page.ads) 
    end while (page.next! && (page.no <= max_page || max_page.zero?))
  end
end

class Source < ActiveRecord::Base
  validates :url, presence: true

  def scrap
    page = Page.new Mechanize.new.get(self.url)
    begin
      Ad.create page.ads
    end while page.next!
  end
end

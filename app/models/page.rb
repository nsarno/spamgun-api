class Page
  AD_SELECTOR = '.list-lbc > a'
  NEXT_PAGE_TEXT = 'Page suivante'

  def initialize page
    @page = page
  end

  def ads
    @page.search(AD_SELECTOR).map do |link|
      Ad.build_with_uri(URI(link['href'])).attributes.compact
    end
  end

  def next!
    next_page = @page.link_with({ text: NEXT_PAGE_TEXT }).try(:click)
    next_page.nil? ? false : self.replace(Page.new next_page)
  end
end

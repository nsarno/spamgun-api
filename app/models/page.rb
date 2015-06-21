class Page
  attr_reader :no

  AD_SELECTOR = '.list-lbc > a'
  NEXT_PAGE_TEXT = 'Page suivante'

  def initialize html_page, no=1
    @html_page = html_page
    @no = no
  end

  def ads
    @html_page.search(AD_SELECTOR).map do |link|
      Ad.build_with_uri(URI(link['href'])).attributes.compact
    end
  end

  def next!
    next_page = @html_page.link_with({ text: NEXT_PAGE_TEXT }).try(:click)
    unless next_page.nil?
      @html_page = next_page
      @no += 1
    end
    next_page.present?
  end
end

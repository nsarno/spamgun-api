require 'mechanize'

class ScrapperJob < ActiveJob::Base
  queue_as :default

  def initialize
    @config = {
      "list_url"    => "http://www.leboncoin.fr/voitures/offres/ile_de_france/?rs=2008&me=100000&f=p",
      "form_url"    => "http://www2.leboncoin.fr/ar/form/0",
      "form_name"   => "James Kilroy",
      "form_email"  => "1i36xe+8pgk9bpdtb7rs@sharklasers.com",
      "form_phone"  => "",
      "form_body"   => "Ce message a été envoyé automatiquement, vous pouvez l'ignorer.",
      "form_cc"     => true
    }
  end

  def perform(*args)
    # Init Mechanize agent
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'

    # Get all ad ids from a LBC list page
    list_page = agent.get @config['list_url']
    ids = list_page.search('.list-lbc > a').map do |link|
      URI(link['href']).path.split('/').last.split('.').first
    end
  end
end

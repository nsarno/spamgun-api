class Ad < ActiveRecord::Base
  enum status: [:pending, :completed]

  belongs_to :source

  validates :uid, uniqueness: { scope: :source }

  FORM_ID = 'reply_form'

  def self.build_with_uri uri
    Ad.new({
      uid: uri.path.split('/').last.split('.').first,
      status: :pending
    })
  end

  def reply
    agent = Mechanize.new
    reply_form = agent.get("#{self.source.form_url}?id=#{uid}").try(:form_with, id: FORM_ID)
    if reply_form.present?
      reply_form.encoding = 'UTF-8'
      reply_form['name'] = self.source.form_name
      reply_form['email'] = self.source.form_email
      reply_form['phone'] = self.source.form_phone
      reply_form['body'] = self.source.form_body
      reply_form.checkbox_with(name: 'cc').check if self.source.form_cc
      self.completed! if self.sent?(reply_form.submit)
    end
  end

  def sent? response_page
    response_page.code.to_i == 200 && response_page.uri.path.split('/').include?('sent')
  end
end

class SourceSerializer < ActiveModel::Serializer
  attributes  :id, :list_url, :form_url, :form_name, :form_email, :form_phone, :form_body, :form_cc,
              :pending_count, :replied_count, :scrapping, :spamming, :scrap_pending, :spam_pending,
              :processing

  has_many :ads
  has_many :jobs

  def pending_count
    object.pending_count
  end

  def replied_count
    object.replied_count
  end

  def scrapping
    object.scrapping?
  end

  def spamming
    object.spamming?
  end

  def scrap_pending
    object.scrap_pending?
  end

  def spam_pending
    object.spam_pending?
  end

  def processing
    object.processing?
  end
end

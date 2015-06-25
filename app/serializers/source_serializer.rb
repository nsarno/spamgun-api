class SourceSerializer < ActiveModel::Serializer
  attributes  :id, :list_url, :form_url, :form_name, :form_email, :form_phone, :form_body, :form_cc,
              :pending_count, :replied_count
  has_many :ads
  has_many :jobs

  def pending_count
    object.pending_count
  end

  def replied_count
    object.replied_count
  end
end

class SourceSerializer < ActiveModel::Serializer
  attributes  :id, :list_url, :form_url, :form_name,
              :form_email, :form_phone, :form_body, :form_cc
end

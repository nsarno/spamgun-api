class Ad < ActiveRecord::Base
  enum status: [:processing, :completed]

  validates :uid, uniqueness: { scope: :origin }
end

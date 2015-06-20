class Ad < ActiveRecord::Base
  enum status: [:idle, :active, :completed]

  validates :uid, uniqueness: { scope: :origin }
end

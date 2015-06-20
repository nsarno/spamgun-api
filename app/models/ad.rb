class Ad < ActiveRecord::Base
  enum status: [:idle, :active, :completed]

  validates :uid, uniqueness: { scope: :origin }

  def self.build_with_uri uri
    Ad.new({ 
      uid: uri.path.split('/').last.split('.').first,
      origin: uri.host,
      status: :idle
    })
  end
end

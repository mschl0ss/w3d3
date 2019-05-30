# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#



class ShortenedUrl < ApplicationRecord
  validates :author_id, :long_url, presence: true

  def self.random_code(long_url, user)
    rc = SecureRandom::urlsafe_base64

    while ShortenedUrl.exists?(long_url: rc)
      rc = SecureRandom::urlsafe_base64
    end

    ShortenedUrl.create!(long_url: long_url, short_url: rc, author_id: user.id)

  end

  def num_clicks
    visits.count
  end

  def num_uniques
    #get all visits
    #count DISTINCT user_ids
    distinct_visitors.count
  end

  def num_recent_uniques
    distinct_visitors.where("updated_at < 10.minutes.ago")
  end

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :su_id,
    class_name: :Visit

  has_many :visitors,
    through: :visits,
    source: :visitor
  
  has_many :distinct_visitors,
    -> { distinct },
    through: :visits,
    source: :visitor
end

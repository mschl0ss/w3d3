# == Schema Information
#
# Table name: visits
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  su_id      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#



class Visit < ApplicationRecord

  def self.record_visit!(user, su)

    Visit.create!(user_id: user.id, su_id: su.id)

  end

  belongs_to :visitor,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :visited_url,
    primary_key: :id,
    foreign_key: :su_id,
    class_name: :ShortenedUrl


end

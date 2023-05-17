# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  comments_count  :integer
#  email           :string
#  likes_count     :integer
#  password_digest :string
#  private         :boolean
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  has_many :followers, :foreign_key => "recipient_id", :class_name => "FollowRequest"

  has_many :own_photos, :foreign_key => "owner_id", :class_name => "Photo"

  has_many :followings, :foreign_key => "sender_id", :class_name => "FollowRequest"

  has_many :likes, :foreign_key => "fan_id", :class_name => "Like"

  has_many :liked_photos, :through => :likes, :source => :photo
 
  has_many(:comments, { :class_name => "Comment", :foreign_key => "commenter_id", :dependent => :destroy })

  has_many(:feed, { :through => :following, :source => :own_photos })

  has_many(:activity, { :through => :following, :source => :liked_photos })

  has_many(:following, { :through => :sent_follow_requests, :source => :recipient_id })

  has_many(:received_follow_requests, { :class_name => "FollowRequest", :foreign_key => "recipient_id", :dependent => :destroy })

end

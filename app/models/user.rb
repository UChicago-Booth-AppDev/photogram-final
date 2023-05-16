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

  has_many :photos
 
  #has_many :comments
  #has_many :commented_photos, :through => :photos, :source => :comment
  #has_many :likes
 # has_many :liked_photos, :through => :photos, :source => :like
  #has_many :follow_requests

end

# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Photo < ApplicationRecord

mount_uploader :image, ImageUploader

belongs_to :poster, :foreign_key => "owner_id", :class_name => "User" 

#has_many :photo_fans, :foreign_key => "photo_id", :class_name => "Photo"

has_many :likes, :foreign_key => "photo_id", :class_name => "Like" 

has_many(:comments, { :class_name => "Comment", :foreign_key => "photo_id", :dependent => :destroy })

has_many(:fans, { :through => :likes, :source => :user })

has_many(:followers, { :through => :owner, :source => :following })

has_many(:fan_followers, { :through => :fans, :source => :following })

end

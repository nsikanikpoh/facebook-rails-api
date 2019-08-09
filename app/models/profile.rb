class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :cover, CoverUploader
  validate  :birth_date_valid
  validates :gender, length: { maximum: 100 }
  validates :location, length: { maximum: 255 }
  validates :bio, length: { maximum: 2000 }
  mount_uploader :avatar, AvatarUploader

  def birth_date_valid
    errors.add(:birthday, "can not be in the future") if
    !birthday.blank? && birthday > Date.today
  end

  def profile_photo(size)
    if !self.avatar.exists? && self.user.image
      self.user.image
    else
      case size
      when 'tac'    then self.avatar.url(:tac)
      when 'thumb'  then self.avatar.url(:thumb)
      when 'medium' then self.avatar.url(:medium)
      else self.avatar.url(:original)
      end
    end
  end
end

class User < ApplicationRecord
  after_create :make_profile
  validates :first_name, presence: true
  validates :last_name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,  :trackable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :linkedin, :google_oauth2, :twitter]
  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :sent_requests, foreign_key: :requester_id, class_name: 'Request', dependent: :destroy
  has_many :received_requests, foreign_key: :requestee_id, class_name: 'Request', dependent: :destroy
  has_many :requestees, through: :sent_requests, dependent: :destroy
  has_many :requesters, through: :received_requests, dependent: :destroy
  has_many :accepted_sent_requests, -> { where accepted: true }, foreign_key: :requester_id, class_name: 'Request'
  has_many :friends, through: :accepted_sent_requests


  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = provider_data.info.name.split(" ")[0]
      user.last_name = provider_data.info.name.split(" ")[1]
      user.image = provider_data.info.image.gsub('http://', 'https://')
    end
  end

  def self.search(search)
    where("lower(users.first_name) LIKE :search OR lower(users.last_name) LIKE :search",
      search: "%#{search.downcase}%").uniq
  end

  def make_profile
    self.create_profile.save
  end
end

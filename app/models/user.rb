class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:github, :google_oauth2]
  
  has_attached_file :avatar, styles: { thumb: '150x150#' }, default_url: "http://via.placeholder.com/150x150"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
         
  validates :username, presence: true
  validates :username, uniqueness: true

  has_many :favorite_breweries
  has_many :favorites, through: :favorite_breweries, source: :breweries

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    # binding.pry
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.nickname
    end
  end
end
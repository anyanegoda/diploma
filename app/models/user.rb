class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :subjects
  has_many :extramular_subjects
  has_many :files_excels
  has_many :settings
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  mount_uploader :avatar, AvatarUploader
  serialize :educational_and_methodical_works, Hash
  serialize :organizational_and_methodical_works, Hash
  serialize :research_works, Hash
  serialize :educational_works, Hash
end

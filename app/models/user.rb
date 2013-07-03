class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :role
  validates_presence_of :username
  # attr_accessible :title, :body
  has_many :subscribes, :dependent => :destroy
  has_many :topics, :through => :subscribes

  has_many :tickets
  has_many :tracks
end

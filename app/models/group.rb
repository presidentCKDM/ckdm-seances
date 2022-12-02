class Group < ActiveRecord::Base

	include Filterable

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  has_many :allowances, dependent: :destroy
  has_many :training_sessions, through: :allowances

  validates_presence_of :name

  def to_s
    name
  end

end

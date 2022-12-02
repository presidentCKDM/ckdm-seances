class Location < ActiveRecord::Base

	include Filterable

	has_many :training_sessions, dependent: :destroy

	validates_presence_of :name

  def to_s
    name
  end
end

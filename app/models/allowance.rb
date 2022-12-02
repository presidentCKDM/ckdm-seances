class Allowance < ActiveRecord::Base

  include Filterable

  belongs_to :group
  belongs_to :training_session, inverse_of: :allowances

  validates_presence_of :group, :training_session
  validates_uniqueness_of :training_session, scope: :group

  def to_s
    group.to_s
  end

end

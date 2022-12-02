class TrainingSession < ActiveRecord::Base

	include Filterable

  belongs_to :location

  has_many :allowances, dependent: :destroy, inverse_of: :training_session
  has_many :groups, through: :allowances
  accepts_nested_attributes_for :allowances, allow_destroy: true, reject_if: :all_blank

	has_many :invitations, dependent: :destroy
  has_many :users, through: :invitations

  validates_presence_of :location, :started_at

  after_save :update_invitations

  scope :in_the_past,   ->{ where("started_at < ?", Date.today) }
  scope :to_come,       ->{ where("started_at >= ?", Date.today) }
  scope :for_groups,    ->(groups) { joins(:allowances).where(allowances: {group: groups}).distinct }

  def to_s
    I18n.l started_at, format: :long
  end

  def is_expected_counter
  	invitations.coming.count
  end

  def is_not_expected_counter
  	invitations.not_coming.count
  end

  def has_not_answered_counter
  	invitations.has_not_answered.count
  end

  def update_invitations
    current_users = users.reload
    futur_users = User.for_groups(groups)

    users_to_add = futur_users - current_users
    users_to_add.each do |user|
      invitations.create(user: user)
    end
    # self.users << users_to_add

    users_to_remove = current_users - futur_users
    self.invitations.where(user: users_to_remove).destroy_all
  end

end

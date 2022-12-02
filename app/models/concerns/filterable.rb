module Filterable

  extend ActiveSupport::Concern

  included do
    scope :only_ids, ->(ids) {
      sql = all
      sql = sql.where(id: ids) unless ids.nil?
      sql
    }
  end

end
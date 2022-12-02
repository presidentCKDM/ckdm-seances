class CreateTrainingSessions < ActiveRecord::Migration
  def change
    create_table :training_sessions do |t|
      t.text :description
      t.datetime :started_at
      t.references :location, index: true

      t.timestamps
    end
  end
end

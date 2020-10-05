class CreateRushingStatistics < ActiveRecord::Migration[6.0]
  def change
    create_table :rushing_statistics do |t|
      t.string :player_name
      t.string :team
      t.string :position
      t.float :attempts_per_game, unsigned: true
      t.integer :attempts, unsigned: true
      t.integer :total_yards, index: true
      t.float :average_yards_per_attempt
      t.float :yards_per_game
      t.integer :total_touchdowns, unsigned: true, index: true
      t.integer :longest_rush, index: true
      t.boolean :touchdown_in_longest_rush, default: false
      t.integer :first_downs, unsigned: true
      t.float :first_down_percentage, unsigned: true
      t.integer :twenty_plus_yards_each, unsigned: true
      t.integer :forty_plus_yards_each, unsigned: true
      t.integer :fumbles, unsigned: true

      t.timestamps
    end
  end
end

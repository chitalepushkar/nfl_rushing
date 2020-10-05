class RushingStatistic < ApplicationRecord
  require 'csv'
  include SharedMethods

  ATTR_MAPPING = {
    'Player': :player_name,
    'Team': :team,
    'Pos': :position,
    'Att/G': :attempts_per_game,
    'Att': :attempts,
    'Yds': :total_yards,
    'Avg': :average_yards_per_attempt,
    'Yds/G': :yards_per_game,
    'TD': :total_touchdowns,
    'Lng': :longest_rush,
    '1st': :first_downs,
    '1st%': :first_down_percentage,
    '20+': :twenty_plus_yards_each,
    '40+': :forty_plus_yards_each,
    'FUM': :fumbles
  }

  attr_reader :longest_rush
  bulk_alias_attribute(ATTR_MAPPING)

  # Converts a rushing_statistic object into CSV entries.
  def self.to_csv
    attributes = ATTR_MAPPING.keys
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |rushing_statistic|
        csv << attributes.map{ |attr| rushing_statistic.send(attr) }
      end
    end
  end

  # Method to handle search, sort and pagination.
  def self.retrieve(options={})
    sort = options[:sort].present? ? options[:sort] : 'id'
    sort_direction = options[:sort_direction].present? ? options[:sort_direction] : 'asc'
    page = options[:page] || 1
    per_page = options[:per_page] || 20

    self.search(options[:query])
      .order("#{sort} #{sort_direction}")
      .page(page)
      .per_page(per_page)
  end

  def self.search(query)
    if query.present?
      return where("lower(player_name) LIKE ?", "%#{sanitize_sql_like(query.downcase)}%")
    end
    all
  end

  # Overriding longest_rush attribute to include touchdown flag
  def longest_rush
    return "#{read_attribute(:longest_rush)}T" if self.touchdown_in_longest_rush
    return "#{read_attribute(:longest_rush)}"
  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Converts rushing stats from String to a numerical value using the method passed.
def convert_to_numerical_value(rushing_stat, conversion_method)
  return rushing_stat if rushing_stat.class != String
  rushing_stat.delete(',').send(conversion_method)
end

#The script pulls data from the rushing.json file to dump data into the DB.
path = File.join(File.dirname(__FILE__), 'rushing.json')
  rushing_records = JSON.parse(File.read(path))
  rushing_records.each do |record|
    rushing_create_params = {
      player_name: record['Player'],
      team: record['Team'],
      position: record['Pos'],
      attempts: convert_to_numerical_value(record['Att'], :to_i),
      attempts_per_game: convert_to_numerical_value(record['Att/G'], :to_f),
      average_yards_per_attempt: convert_to_numerical_value(record['Avg'], :to_f),
      total_yards: convert_to_numerical_value(record['Yds'], :to_i),
      yards_per_game: convert_to_numerical_value(record['Yds/G'], :to_f),
      total_touchdowns: convert_to_numerical_value(record['TD'], :to_i),
      first_downs: convert_to_numerical_value(record['1st'], :to_i),
      first_down_percentage: convert_to_numerical_value(record['1st%'], :to_f),
      twenty_plus_yards_each: convert_to_numerical_value(record['20+'], :to_i),
      forty_plus_yards_each: convert_to_numerical_value(record['40+'], :to_i),
      fumbles: convert_to_numerical_value(record['FUM'], 'to_i')
    }

    if record['Lng'].present?
      if record['Lng'].class == String && record['Lng'].include?('T')
        longest_rush = record['Lng'].delete('T')
        rushing_create_params.merge!(
          longest_rush: convert_to_numerical_value(longest_rush, :to_i),
          touchdown_in_longest_rush: true
        )
      else
        rushing_create_params.merge!(
          longest_rush: convert_to_numerical_value(record['Lng'], :to_i),
          touchdown_in_longest_rush: false
        )
      end
    end

    RushingStatistic.create!(rushing_create_params)
  end
p 'Rushing statistics seeded successfully.'

json.set! :data do
  json.array! @rushing_statistics, partial: 'rushing_statistics/rushing_statistic', as: :rushing_statistic
end
json.total @rushing_statistics.count
json.csv_url request.base_url  + rushing_statistics_path(format:'csv', params: request.query_parameters)

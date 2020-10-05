class RushingStatisticsController < ApplicationController
  include ActionController::MimeResponds

  # GET /rushing_statistics
  def index
    @rushing_statistics = RushingStatistic.retrieve(index_params)

    respond_to do |format|
      format.json {render 'index'}
      format.csv do
        response.headers['Content-Disposition'] = "attachment"
        response.headers['Content-Type'] ||= 'text/csv'
        send_data @rushing_statistics.to_csv, filename: "rushing_statistics-#{Date.today}.csv"
      end
    end
  end

  private
    def index_params
      params.permit(:query, :sort, :sort_direction, :page, :per_page)
    end
end

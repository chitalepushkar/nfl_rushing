# nfl_rushing
An app to list NFL rushing statistics with search, sort, paginate and download functionality

### Prerequisites
1. Ruby
2. PostgreSQL
3. NPM/Yarn

### Installation
1. Install RVM and ruby: https://rvm.io/rvm/install
2. Install PostgreSQL for Ubuntu using the following [guide](https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-ubuntu-18-04).
Refer the following [guide](https://www.postgresql.org/download/macosx/) for installation procedure for Mac.
3. Please refer the following [guide](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm) to install NodeJS and NPM.
You can also install Yarn with the help of this [page](https://classic.yarnpkg.com/en/docs/install/#debian-stable)
4. Clone the repository

### Setup

#### Backend
1. Change directory to `nfl_rushing_backend`
2. Run command `bundle install`. This will install all the gems required to run the application.
3. In the project's `config/database.yml` file, change the username, password, hostname to the PSQL server setup on your local machine.
```
default: &default
  adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see Rails configuration guide
  # https://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  host: <%= ENV["DEV_DB_HOSTNAME"] || 'localhost' %>
  username: <%= ENV["DEV_DB_USERNAME"] || 'nfl_admin' %>
  password: <%= ENV["DEV_DB_PASSWORD"] || 'password' %>

development:
  <<: *default
  database: <%= ENV["DEV_DB_NAME"] || 'nfl_rushing_backend_development' %>
```
4. Once done run the following commands:
a. `rake db:create` to create the development database.
b. `rake db:migrate` to create the rushing_statistics table.
c. `rake db:seed` to dump the NFL rushing statistics data present in the rushing.json file into the DB.
d. Once all of these steps are performed, start the server using this command: `rails s -p 3001`



#### Frontend
1. Change directory to `nfl_rushing_frontend`.
2. Run command `npm install` to download all the packages mentioned in the package.json file.
3. Finally run `npm start` to start the react App on port 3000.

### Usage

To checkout whether the app is working, go to `http:localhost:3000` on your browser. A tabular UI containing all the Rushing statistics will be displayed with the following features.
1. The table headers are clickable and can be use to toggle the sorting order of individual columns.
2. A search bar is provided in order to search results by Player name.
3. The pagination links at the bottom of the table can be used to navigate between different pages. You can also control the number of entries per page by choosing the select dropdown options containing a few fixed values.
4. Lastly, you can download the filtered/sorted results into a CSV file by clicking on the green `Download` button at the top.

#### Backend API:
The backend provides a GET API to retrieve the rushing statistics based on the user's inputs.
You can try firing the Backend APIs with the help of the following request query parameters:
1. `page` and `per_page`: These 2 attributes are used to choose the current page and the total entries per page.
2. `query` attribute can be passed to filter by Player names.
3. `sort` and `sort_direction` attributes are passed to order the result based on the selected field's ascending or descending order.
4. The result is returned in the form of a JSON object.

A sample request looks something like this:
```
http://localhost:3001/rushing_statistics?query=Georg&per_page=20&page=1&sort=total_touchdowns&sort_direction=asc
```

A sample JSON response will look something like this: 
```
{
	"data": [{
		"id": 147,
		"player_name": "George Farmer",
		"team": "SEA",
		"position": "RB",
		"attempts_per_game": 0.5,
		"attempts": 1,
		"total_yards": 1,
		"average_yards_per_attempt": 1.0,
		"yards_per_game": 0.5,
		"total_touchdowns": 0,
		"longest_rush": "1",
		"touchdown_in_longest_rush": false,
		"first_downs": 0,
		"first_down_percentage": 0.0,
		"twenty_plus_yards_each": 0,
		"forty_plus_yards_each": 0,
		"fumbles": 0
	}, {
		"id": 251,
		"player_name": "George Atkinson",
		"team": "CLE",
		"position": "RB",
		"attempts_per_game": 0.4,
		"attempts": 7,
		"total_yards": 34,
		"average_yards_per_attempt": 4.9,
		"yards_per_game": 2.1,
		"total_touchdowns": 1,
		"longest_rush": "11",
		"touchdown_in_longest_rush": false,
		"first_downs": 3,
		"first_down_percentage": 42.9,
		"twenty_plus_yards_each": 0,
		"forty_plus_yards_each": 0,
		"fumbles": 0
	}],
	"total": 2,
	"csv_url": "http://localhost:3001/rushing_statistics.csv?page=1\u0026per_page=20\u0026query=Georg\u0026sort=total_touchdowns\u0026sort_direction=asc"
}
```

5. You can also download the CSV report using the above API by adding the CSV extension at the end of the original url:
```
http://localhost:3001/rushing_statistics.csv?query=Georg&per_page=20&page=1&sort=total_touchdowns&sort_direction=asc
```

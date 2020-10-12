# _Volunteer_tracker_

_Version 1, 10/9/2020_

#### _An application that tracks projects and the volunteers working on them_

### By: _**Brycen Bartolome**_

## Description

This project connects to a postgreSQL database. there is a production Database: volunteer_tracker, a development Database: volunteer_tracker_test, and the tables of the databases are as follows, projects and volunteers. I also created a backup in the root directory.

_With this project:_

- a user will be able to view, add, update and delete projects.
- a user will also be able to view and add volunteers.
- lastly they will be able to add volunteers to a project.

## Setup & Installation

- Clone project to desktop <code>\$ git clone https://github.com/BrycenGit/volunteer_tracking_device.git</code>
- Move to project directory <code>\$ cd volunteer_tracker</code>
- Open project in vscode <code>\$ code .</code>
- In terminal run <code>\$ bundle install</code>
- In terminal run <code>\$ createdb volunteer_tracker</code>
- In terminal run <code>\$ psql volunteer_tracker < database_backup.sql</code>
- In terminal run <code>\$ createdb -T volunteer_tracker volunteer_tracker_test</code>
- In terminal run <code>\$ touch .env</code>

### If using windows

- In .env file add text PG_PASS={YOUR POSTGRESS PASSWORD WITHOUT BRACES OR QUOTES}

### If using mac

- remove the :password key value pair from DB = PG.connect methods on app.rb and spec_helper.rb

### Then

- In terminal run <code>\$ rspec</code>
- In vscode terminal run <code>\$ ruby app.rb</code>

## Known Bugs

Make sure you add .env file with text PG_PASS={YOUR POSTGRESS PASSWORD WITHOUT BRACES OR QUOTES}
i.e PG_PASS=password

## Technologies Used

- Ruby
- Gems: rspec, rack, sinatra, sinatra-contrib, pry, rspec, capybara, pg, dotenv

### License

Copyright (c) 2020 **Brycen Bartolome**

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Adam Mansell's Volunteer Tracker Project

### Ruby Friday Project for Epicodus, 10/22/2020

## **By Adam Mansell**

## Description
In this project, we develope a site where we can create projects and add volunteers to them.

## Setup

## Database Setup:

You will need postgreSQL installed in your machine.

In terminal, type: `psql` to connect to your psql console.

Then create the `volunteer_tracker` database:

```
CREATE DATABASE volunteer_tracker;
```
Then, connect to the volunteer_tracker database:

```
\c volunteer_tracker;
```

Finally, import the data from the `database_backup.sql` file:

```
\i 'FULL_PATH_TO_DATABASE_BACKUP.SQL_FILE'
e.g.
\i '/Users/adammansell/desktop/Epicodus Projects/volunteer_tracker/database_backup.sql'
```

## Setup Sinatra Application

Install the project dependencies:

```
bundle install
```

Run the sinatra app:

```
ruby app.rb
```

Visit: `http://localhost:4567` to see the application in action!

## Technologies Used
For this project I used Ruby, Sinatra framework and Postgres as a relation database.

## Legal
_Copyright (c) 2020 Adam Mansell_


_This software is licensed under the MIT license._
# Project Template: Rails API

## Description

Rails backend

## Requirements

- Ruby 2.7.4
- Postgresql

See Environment Setup below for instructions on installing these tools if you
don't already have them.

## Setup

Run:

```sh
bundle install
rails db:create
rails db:seed #OPTIONAL: there are some seed data to generate doctors and patients
```

For any changes to the schema run:

```sh
rails db:migrate
```

To check the status of your migrations run:

```sh
rails db:migrate:status
```

You can use the following commands to run the application:

- `rails s`: run the backend on [http://localhost:3000](http://localhost:3000)

## Routes

| doctor routes                          | outlets                                      |
| -------------------------------------- | -------------------------------------------- |
| /api/v1/doctors                        | Listing all doctors                          |
| /api/v1/doctors/:id                    | Listing doctor by id                         |
| /api/v1/doctors/:id                    | Deleting doctor by id                        |
| /api/v1/doctors/:id/appointment/:ap_id | Deleting specific appointment by doctor's id |
| /api/v1/doctors/:id/day/:day           | Listing all doctor's appoinments for the day |
| /api/v1/doctors/:id/all_appointments   | Listing all doctor's                         |

| patient routes       | outlets                |
| -------------------- | ---------------------- |
| /api/v1/patients     | Listing all patients   |
| /api/v1/patients/:id | Listing patient by id  |
| /api/v1/patients/:id | Deleting patient by id |

| appointment routes             | outlets                                 |
| ------------------------------ | --------------------------------------- |
| /api/v1/appointments           | Listing all appointments                |
| /api/v1/appointments/:id       | Listing appointment by id               |
| /api/v1/appointments/:id       | Deleting appointment by id              |
| /api/v1//appointments/day/:day | getting all appointments by for the day |

## Environment Setup

### Install the Latest Ruby Version

Verify which version of Ruby you're running by entering this in the terminal:

```sh
ruby -v
```

You should also install the latest versions of `bundler` and `rails`:

```sh
gem install bundler
gem install rails
```

### Install Postgresql

#### PostgreSQL Installation for WSL

To install Postgres for WSL, run the following commands from your Ubuntu terminal:

```sh
sudo apt update
sudo apt install postgresql postgresql-contrib libpq-dev
```

Then confirm that Postgres was installed successfully:

```sh
psql --version
```

Run this command to start the Postgres service:

```sh
sudo service postgresql start
```

Finally, you'll also need to create a database user so that you are able to
connect to the database from Rails. First, check what your operating system
username is:

```sh
whoami
```

If your username is "myusername", for example, you'd need to create a Postgres user
with that same name. To do so, run this command to open the Postgres CLI:

```sh
sudo -u postgres -i
```

From the Postgres CLI, run this command (replacing "myusername" with your username):

```sh
createuser -sr myusername
```

Then enter `control + d` or type `logout` to exit.

[This guide][postgresql wsl] has more info on setting up Postgres on WSL if you
get stuck.

[postgresql wsl]: https://docs.microsoft.com/en-us/windows/wsl/tutorials/wsl-database#install-postgresql

#### Postgresql Installation for OSX

To install Postgres for OSX, you can use Homebrew:

```sh
brew install postgresql
```

Once Postgres has been installed, run this command to start the Postgres
service:

```sh
brew services start postgresql
```

## Troubleshooting

If you ran into any errors along the way, here are some things you can try to
troubleshoot:

- If you're on a Mac and got a server connection error when you tried to run
  `rails db:create`, one option for solving this problem for Mac users is to
  install the Postgres app. To do this, first uninstall `postgresql` by running
  `brew remove postgresql`. Next, download the app from the
  [Postgres downloads page][postgres downloads page] and install it. Launch the
  app and click "Initialize" to create a new server. You should now be able to
  run `rails db:create`.

- If you're using WSL and got the following error running `rails db:create`:

  ```txt
  PG::ConnectionBad: FATAL:  role "yourusername" does not exist
  ```

  The issue is that you did not create a role in Postgres for the default user
  account. Check [this video](https://www.youtube.com/watch?v=bQC5izDzOgE) for
  one possible fix.

[postgres downloads page]: https://postgresapp.com/downloads.html

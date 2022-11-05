# Profinder

## Requirements

To setup this project you must have following dependencies installed in your system

```
ruby version 3.1.2
rails version 7.0
yarn
```

## Setup steps

Cloning the repo
```
git clone https://github.com/appsimpactacademy/profinder.git
```

Switch to profinder
```
cd profinder
```

Setup rails app
```
bundle install
yarn build:css
rails db:migrate
rails db:seed
```

## Running profinder

In the terminal run 

```
rails s
```

And then visit http://localhost:3000 for root page

And http://localhost:3000/users for users index page.

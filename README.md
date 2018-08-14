# README

About the project:

* Ruby version: 2.5.1

* Install dependencies: 
```sh
$ bundle install
```

* Database initialization: 
```sh
$ rails db:setup
```

* How to run the tests: 
```sh
$ bundle exec rspec
```

* How to configure the subdomain:
```sh
$ sudo nano /etc/hosts
```
After that add at the end of the file:
```sh
127.0.0.1 api.beer.test
```

* Start project: 
```sh
$ rails s
```
Now you can access the endpoint beers using: api.beer.test:3000/v1/beers

# README

Demo api using jwt from pluralsight
https://www.pluralsight.com/guides/ruby-ruby-on-rails/token-based-authentication-with-ruby-on-rails-5-api

Get auth token:
$ curl -H "Content-Type: application/json" -X POST -d '{"username":"adminuser", "password":"test1234", "client_name":"Client01"}' http://localhost:3000/authenticate

Returns:
{"auth_token":"xxxxxxxxxx.yyyyyyyyyyyy.zzzzzzzzzz"}

Use auth token:
$ curl -H "Authorization: xxxxxxxxxx.yyyyyyyyyyyy.zzzzzzzzzz" http://localhost:3000/items


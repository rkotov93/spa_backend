# README
[![Build Status](https://travis-ci.org/rkotov93/spa_backend.svg?branch=master)](https://travis-ci.org/rkotov93/spa_backend)

This is an learning project for MKDEV mentoring resource.

Requisites
--
You need to have PostgreSQL 9.4 installed

Bootstraping
--
To start this application do following steps:
* `bundle`
* Add `config/application.yml` with `db_user: <Your database user>` and `db_password: <Your database user password>`
* `rake db:create` `rake db:migrate`
* `rails s`

# README

[![Build Status](https://travis-ci.org/rkotov93/spa_backend.svg?branch=master)](https://travis-ci.org/rkotov93/spa_backend)

This is a Rails 5 API backend for [SPA application](https://github.com/rkotov93/spa_frontend) written in react. This application developed along with MKDEV mentorship program.

Requisites
--
You need to have `PostgreSQL 9.4` installed.

Bootstraping
--
To start this application do following steps:
* `bundle`
* Add `config/application.yml` with

  ```
  db_user: <Your database user>
  db_password: <Your database user password>
  ```
* `rake db:create` `rake db:migrate`
* `rails s`

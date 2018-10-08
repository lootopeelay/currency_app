# README

This README provides a guide to getting the Currency Exchange application up and running.

It assumes you are familiar with installing Ruby on Rails. 

## Developed on:

Distributor ID:	Ubuntu

Description:	Ubuntu 16.04.5 LTS

Release:	16.04

Codename:	xenial

## Ruby on Rails Version

ruby 2.5.1p57 (2018-03-29 revision 63029) [x86_64-linux]

Rails 5.2.1

## Pre-requisites

sudo apt install ruby-foreman

## Deploying the application

_Unzip the supplied archive and then in the root of the application run:_

bundle install

yarn install

rake db:migrate && rake db:test:prepare

./fetch_rates.sh

## Running the application

foreman start -f Procfile.dev -p 3000

Go to _http://localhost:3000/_ in your browser

## Cron Job to fetch rates

Simply add an item to the crontab that calls the ./fetch_rates.sh in the application root 

## Running the tests

rake spec

# Ruby on Rails template for AWS Elastic Beanstalk

This repository includes templates that can be used to setup your Rails application for deployment on AWS Elastic Beanstalk.

## Architecture
These templates were used to deploy the following configuration:

* Rails 6 application on AWS EB behind AWS ALB
* Sidekiq on a separate AWS EB instances
* Anycable on AWS EB behind AWS NLB

## Legend

* X-Project – name of project
* x-project.com – project domain

## Directory Structure

* `x-project-server` – templates that should be added to Rails app
* `x-project-ci-image` – templates for preliminirary image

## Project Schema

![Schema](https://raw.githubusercontent.com/jetrockets/rails-elastic-beanstalk/master/.support/schema.png)
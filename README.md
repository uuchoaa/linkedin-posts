# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# TO DO

- [ ] refactor: create a `Cuy::DefaultController`
  - [ ] Sets all crud operations with Cuy::DefaultIndex, Cuy::DefaultForm, etc
  - [ ] `Cuy::DefaultForm` infer params to `Cuy::ModelForm`
  - [ ] Implement `Cuy::ModelForm`
  - [ ] Update `PostsController < Cuy::DefaultController`
  - [ ] Flash messages infer model name

- [ ] feat: add localization support
  - [ ] Update flash messages `Cuy::DefaultController`
  - [ ] Upatte datetime field
  - [ ] ...

- [ ] feat: add crud of Author
  - [ ] Only basic fields, no relation  
  - [ ] ...

- [ ] feat: post has many authors
  - [ ] Register and load relations fields
  - [ ] ...

- [ ] test: add 2e2 ?
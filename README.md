# Pumarex

A movie theater web application built with **Phoenix Framework 1.3** and **Elm 0.18**.

Don't take it seriously. It's just an exercise for me to learn Elm and try the
new features included in Phoenix Framework 1.3

## TODO list

- [x] Room management.
  - [x] Room list.
  - [x] Room creation.
- [x] Screening management
  - [x] Screening list.
  - [x] Screening creation.
- [x] Box office.
- [x] User authentication.

## Development setup

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Install Elm dependencies with `cd assets/elm && elm-package install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

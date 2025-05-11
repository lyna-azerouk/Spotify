# SpotifyApi

### Description
A REST API that wraps the Spotify API. The goal is to retrieve the list of albums by artist name. If the artist does not exist in the database, it will be created along with their list of albums.

Swagger documentation has been provided to test the API.
(I wrote a short report to explain the implementation and some of the technical choices.)

### SetUp
To set up the environment file:

  * Define the `SPOTIFY_CLIENT_ID` and `SPOTIFY_CLIENT_SECRET` varibales.

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Run `mix ecto.create`to create the DataBase
  * Run `mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Documentation
 * http://localhost:4000/swaggerui
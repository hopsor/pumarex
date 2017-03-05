# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pumarex.Repo.insert!(%Pumarex.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Pumarex.Repo.insert_all(Pumarex.Theater.Movie, [
  %{
    title: "Manchester by the Sea",
    year: 2006,
    duration: 137,
    director: "Kenneth Lonergan",
    cast: "Casey Affleck, Michelle Williams, Kyle Chandler",
    overview: "A depressed uncle is asked to take care of his teenage nephew after the boy's father dies.",
    poster: "https://image.tmdb.org/t/p/w640/hp39iyhbbTZKLYXD2FG9I2NnpjU.jpg",
    inserted_at: Ecto.DateTime.utc,
    updated_at: Ecto.DateTime.utc
  },
  %{
    title: "Moonlight",
    year: 2016,
    duration: 111,
    director: "Barry Jenkins",
    cast: "Mahershala Ali, Shariff Earp, Duan Sanderso",
    overview: "A chronicle of the childhood, adolescence and burgeoning adulthood of a young black man growing up in a rough neighborhood of Miami.",
    poster: "https://image.tmdb.org/t/p/w640/qAwFbszz0kRyTuXmMeKQZCX3Q2O.jpg",
    inserted_at: Ecto.DateTime.utc,
    updated_at: Ecto.DateTime.utc
  },
  %{
    title: "La La Land",
    year: 2006,
    duration: 128,
    director: "Damien Chazelle",
    cast: "Ryan Gosling, Emma Stone, Rosemarie DeWitt",
    overview: "A jazz pianist falls for an aspiring actress in Los Angeles.",
    poster: "https://image.tmdb.org/t/p/w640/i712GLJklSVeuuNiz4egs7L1BvF.jpg",
    inserted_at: Ecto.DateTime.utc,
    updated_at: Ecto.DateTime.utc
  },
  %{
    title: "Arrival",
    year: 2006,
    duration: 118,
    director: "Denis Villeuneve",
    cast: "Amy Adams, Jeremy Renner, Forest Whitaker",
    overview: "When twelve mysterious spacecraft appear around the world, linguistics professor Louise Banks is tasked with interpreting the language of the apparent alien visitors.",
    poster: "https://image.tmdb.org/t/p/w640/AcilyyFwtFuZAkSD9oi2CBw4J9Q.jpg",
    inserted_at: Ecto.DateTime.utc,
    updated_at: Ecto.DateTime.utc
  }
])

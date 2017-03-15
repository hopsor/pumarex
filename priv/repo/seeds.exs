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

alias Pumarex.{Repo, Theater}

Repo.insert_all(Theater.Movie, [
  %{
    title: "Manchester by the Sea",
    year: 2016,
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
    year: 2016,
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
    year: 2016,
    duration: 118,
    director: "Denis Villeuneve",
    cast: "Amy Adams, Jeremy Renner, Forest Whitaker",
    overview: "When twelve mysterious spacecraft appear around the world, linguistics professor Louise Banks is tasked with interpreting the language of the apparent alien visitors.",
    poster: "https://image.tmdb.org/t/p/w640/AcilyyFwtFuZAkSD9oi2CBw4J9Q.jpg",
    inserted_at: Ecto.DateTime.utc,
    updated_at: Ecto.DateTime.utc
  },
  %{
    title: "Hidden Figures",
    year: 2016,
    duration: 127,
    director: "Theodore Melfi",
    cast: "Taraji P. Henson, Octavia Spencer, Janelle Monáe",
    overview: "The story of a team of African-American women mathematicians who served a vital role in NASA during the early years of the US space program.",
    poster: "https://image.tmdb.org/t/p/w640/6cbIDZLfwUTmttXTmNi8Mp3Rnmg.jpg",
    inserted_at: Ecto.DateTime.utc,
    updated_at: Ecto.DateTime.utc
  },
  %{
    title: "Hell or High Water",
    year: 2016,
    duration: 102,
    director: "David Mackenzie",
    cast: "Jeff Bridges, Chris Pine, Ben Foster",
    overview: "A divorced dad and his ex-con brother resort to a desperate scheme in order to save their family's farm in West Texas.",
    poster: "https://image.tmdb.org/t/p/w640/6YOrNBdoXvT8aC5VPLkkN6t5z0V.jpg",
    inserted_at: Ecto.DateTime.utc,
    updated_at: Ecto.DateTime.utc
  },
  %{
    title: "Lion",
    year: 2016,
    duration: 118,
    director: "Garth Davies",
    cast: "Dev Patel, Nicole Kidman, Rooney Mara",
    overview: "A five-year-old Indian boy gets lost on the streets of Calcutta, thousands of kilometers from home. He survives many challenges before being adopted by a couple in Australia; 25 years later, he sets out to find his lost family.",
    poster: "https://image.tmdb.org/t/p/w640/pq4I860JAol0hFXp2H4VFA2lrU6.jpg",
    inserted_at: Ecto.DateTime.utc,
    updated_at: Ecto.DateTime.utc
  },
  %{
    title: "Fences",
    year: 2016,
    duration: 138,
    director: "Denzel Washington",
    cast: "Denzel Washington, Viola Davis, Stephen Henderson",
    overview: "A working-class African-American father tries to raise his family in the 1950s, while coming to terms with the events of his life.",
    poster: "https://image.tmdb.org/t/p/w640/e3QX3tY0fBR1GuxdP0mwpN16cqI.jpg",
    inserted_at: Ecto.DateTime.utc,
    updated_at: Ecto.DateTime.utc
  },
  %{
    title: "Hacksaw Ridge",
    year: 2016,
    duration: 139,
    director: "Mel Gibson",
    cast: "Andrew Garfield, Sam Worthington, Luke Bracey",
    overview: "WWII American Army Medic Desmond T. Doss, who served during the Battle of Okinawa, refuses to kill people and becomes the first Conscientious Objector in American history to win the Congressional Medal of Honor.",
    poster: "https://image.tmdb.org/t/p/w640/bndiUFfJxNd2fYx8XO610L9a07m.jpg",
    inserted_at: Ecto.DateTime.utc,
    updated_at: Ecto.DateTime.utc
  }
])

seats =
  1..15
  |> Enum.flat_map(fn (row) ->
    Enum.map(1..15, fn (column) ->
      %{row: row, column: column}
    end)
  end)
  |> Enum.reject(fn (seat) -> seat.row == 7 end)

Theater.create_room(%{name: "Room 1", seats: seats})

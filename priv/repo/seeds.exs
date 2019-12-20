# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     DownUnderSports.Repo.insert!(%DownUnderSports.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias DownUnderSports.Repo
alias DownUnderSports.Metas

# SEED COUNTRIES
{
  {
    "USA", "United States of America", 2,
    """
    %(care_of ? "%[subject]%%n%C/O: %[care_of]%" : (company ? "ATTN: %[subject]%" : subject))%
    %?company?%
    %[lines]%
    %[locality]%, %[state]% %[zip]%
    """
  },
}
  |>  Tuple.Iterator.each(
        fn {_, {code, full, state_abbr_length, address_format}} ->
          Repo.get_by(Metas.Country, code: code) ||
            Repo.insert!(%Metas.Country{ code: code, full: full, state_abbr_length: state_abbr_length, address_format: address_format })
        end
      )


# SEED STATES
{
  { "AL", "Alabama",              "USA", -6,  true  },
  { "AK", "Alaska",               "USA", -9,  true  },
  { "AZ", "Arizona",              "USA", -7,  false },
  { "AR", "Arkansas",             "USA", -6,  true  },
  { "CA", "California",           "USA", -8,  true  },
  { "CO", "Colorado",             "USA", -7,  true  },
  { "CT", "Connecticut",          "USA", -5,  true  },
  { "DE", "Delaware",             "USA", -5,  true  },
  { "DC", "District of Columbia", "USA", -5,  true  },
  { "FL", "Florida",              "USA", -5,  true  },
  { "GA", "Georgia",              "USA", -5,  true  },
  { "HI", "Hawaii",               "USA", -10, false },
  { "ID", "Idaho",                "USA", -7,  true  },
  { "IL", "Illinois",             "USA", -6,  true  },
  { "IN", "Indiana",              "USA", -5,  true  },
  { "IA", "Iowa",                 "USA", -6,  true  },
  { "KS", "Kansas",               "USA", -6,  true  },
  { "KY", "Kentucky",             "USA", -5,  true  },
  { "LA", "Louisiana",            "USA", -6,  true  },
  { "ME", "Maine",                "USA", -5,  true  },
  { "MD", "Maryland",             "USA", -5,  true  },
  { "MA", "Massachusetts",        "USA", -5,  true  },
  { "MI", "Michigan",             "USA", -5,  true  },
  { "MN", "Minnesota",            "USA", -6,  true  },
  { "MS", "Mississippi",          "USA", -6,  true  },
  { "MO", "Missouri",             "USA", -6,  true  },
  { "MT", "Montana",              "USA", -7,  true  },
  { "NE", "Nebraska",             "USA", -6,  true  },
  { "NV", "Nevada",               "USA", -8,  true  },
  { "NH", "New Hampshire",        "USA", -5,  true  },
  { "NJ", "New Jersey",           "USA", -5,  true  },
  { "NM", "New Mexico",           "USA", -7,  true  },
  { "NY", "New York",             "USA", -5,  true  },
  { "NC", "North Carolina",       "USA", -5,  true  },
  { "ND", "North Dakota",         "USA", -6,  true  },
  { "OH", "Ohio",                 "USA", -5,  true  },
  { "OK", "Oklahoma",             "USA", -6,  true  },
  { "OR", "Oregon",               "USA", -8,  true  },
  { "PA", "Pennsylvania",         "USA", -5,  true  },
  { "RI", "Rhode Island",         "USA", -5,  true  },
  { "SC", "South Carolina",       "USA", -5,  true  },
  { "SD", "South Dakota",         "USA", -7,  true  },
  { "TN", "Tennessee",            "USA", -6,  true  },
  { "TX", "Texas",                "USA", -6,  true  },
  { "UT", "Utah",                 "USA", -7,  true  },
  { "VT", "Vermont",              "USA", -5,  true  },
  { "VA", "Virginia",             "USA", -5,  true  },
  { "WA", "Washington",           "USA", -8,  true  },
  { "WV", "West Virginia",        "USA", -5,  true  },
  { "WI", "Wisconsin",            "USA", -6,  true  },
  { "WY", "Wyoming",              "USA", -7,  true  }
}
  |>  Tuple.Iterator.each(
        fn {_, {abbr, full, country_code, offset, dst}} ->
          Repo.get_by(Metas.State, abbr: abbr)
            || Repo.insert!(%Metas.State{ abbr: abbr, full: full, country_code: country_code, tz_offset: offset, observes_dst: dst })
        end
      )

# SEED SPORTS
{
  { "XC", "Cross Country",   "XC",  "Cross Country",    false, false },
  { "GF", "Golf",            "GF",  "Golf",             false, false },
  { "TF", "Track and Field", "TF",  "Track and Field",  false, false },
  { "CH", "Cheer",           "CH",  "Cheer",            false, false },
  { "BB", "Basketball",      "BBB", "Boys Basketball",  true,  false },
  { "BB", "Basketball",      "GBB", "Girls Basketball", true,  false },
  { "VB", "Volleyball",      "VB",  "Volleyball",       true,  false },
  { "FB", "Football",        "FB",  "Football",         true,  false },
  { "ST", "Staff",           "STF", "Staff",            false, true  }
}
  |>  Tuple.Iterator.each(
        fn {_, {abbr, full, abbr_gender, full_gender, numbered, meta}} ->
          Repo.get_by(Metas.Sport, abbr_gender: abbr_gender)
            || Repo.insert!(%Metas.Sport{ abbr: abbr, full: full, abbr_gender: abbr_gender, full_gender: full_gender, is_numbered: numbered, is_meta: meta })
        end
      )

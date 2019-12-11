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
us_address_format = """
%SUBJECT%
%LINE1%<IFPRESENT>
%LINE2%</IFPRESENT><IFPRESENT>
%LINE3%</IFPRESENT>
%CITY%, %STATE% %ZIP%
"""
Repo.get_by(Metas.Country, code: "USA") || Repo.insert!(%Metas.Country{ code: "USA", full: "United States of America", address_format: us_address_format, state_abbr_length: 2 })

# SEED STATES
Repo.get_by(Metas.State, abbr: "AL")
  || Repo.insert!(%Metas.State{ abbr: "AL", full: "Alabama", country_code: "USA", tz_offset: -6, observes_dst: true })
Repo.get_by(Metas.State, abbr: "AK")
  || Repo.insert!(%Metas.State{ abbr: "AK", full: "Alaska", country_code: "USA", tz_offset: -9, observes_dst: true })
Repo.get_by(Metas.State, abbr: "AZ")
  || Repo.insert!(%Metas.State{ abbr: "AZ", full: "Arizona", country_code: "USA", tz_offset: -7, observes_dst: false })
Repo.get_by(Metas.State, abbr: "AR")
  || Repo.insert!(%Metas.State{ abbr: "AR", full: "Arkansas", country_code: "USA", tz_offset: -6, observes_dst: true })
Repo.get_by(Metas.State, abbr: "CA")
  || Repo.insert!(%Metas.State{ abbr: "CA", full: "California", country_code: "USA", tz_offset: -8, observes_dst: true })
Repo.get_by(Metas.State, abbr: "CO")
  || Repo.insert!(%Metas.State{ abbr: "CO", full: "Colorado", country_code: "USA", tz_offset: -7, observes_dst: true })
Repo.get_by(Metas.State, abbr: "CT")
  || Repo.insert!(%Metas.State{ abbr: "CT", full: "Connecticut", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "DE")
  || Repo.insert!(%Metas.State{ abbr: "DE", full: "Delaware", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "DC")
  || Repo.insert!(%Metas.State{ abbr: "DC", full: "District of Columbia", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "FL")
  || Repo.insert!(%Metas.State{ abbr: "FL", full: "Florida", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "GA")
  || Repo.insert!(%Metas.State{ abbr: "GA", full: "Georgia", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "HI")
  || Repo.insert!(%Metas.State{ abbr: "HI", full: "Hawaii", country_code: "USA", tz_offset: -10, observes_dst: false })
Repo.get_by(Metas.State, abbr: "ID")
  || Repo.insert!(%Metas.State{ abbr: "ID", full: "Idaho", country_code: "USA", tz_offset: -7, observes_dst: true })
Repo.get_by(Metas.State, abbr: "IL")
  || Repo.insert!(%Metas.State{ abbr: "IL", full: "Illinois", country_code: "USA", tz_offset: -6, observes_dst: true })
Repo.get_by(Metas.State, abbr: "IN")
  || Repo.insert!(%Metas.State{ abbr: "IN", full: "Indiana", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "IA")
  || Repo.insert!(%Metas.State{ abbr: "IA", full: "Iowa", country_code: "USA", tz_offset: -6, observes_dst: true })
Repo.get_by(Metas.State, abbr: "KS")
  || Repo.insert!(%Metas.State{ abbr: "KS", full: "Kansas", country_code: "USA", tz_offset: -6, observes_dst: true })
Repo.get_by(Metas.State, abbr: "KY")
  || Repo.insert!(%Metas.State{ abbr: "KY", full: "Kentucky", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "LA")
  || Repo.insert!(%Metas.State{ abbr: "LA", full: "Louisiana", country_code: "USA", tz_offset: -6, observes_dst: true })
Repo.get_by(Metas.State, abbr: "ME")
  || Repo.insert!(%Metas.State{ abbr: "ME", full: "Maine", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "MD")
  || Repo.insert!(%Metas.State{ abbr: "MD", full: "Maryland", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "MA")
  || Repo.insert!(%Metas.State{ abbr: "MA", full: "Massachusetts", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "MI")
  || Repo.insert!(%Metas.State{ abbr: "MI", full: "Michigan", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "MN")
  || Repo.insert!(%Metas.State{ abbr: "MN", full: "Minnesota", country_code: "USA", tz_offset: -6, observes_dst: true })
Repo.get_by(Metas.State, abbr: "MS")
  || Repo.insert!(%Metas.State{ abbr: "MS", full: "Mississippi", country_code: "USA", tz_offset: -6, observes_dst: true })
Repo.get_by(Metas.State, abbr: "MO")
  || Repo.insert!(%Metas.State{ abbr: "MO", full: "Missouri", country_code: "USA", tz_offset: -6, observes_dst: true })
Repo.get_by(Metas.State, abbr: "MT")
  || Repo.insert!(%Metas.State{ abbr: "MT", full: "Montana", country_code: "USA", tz_offset: -7, observes_dst: true })
Repo.get_by(Metas.State, abbr: "NE")
  || Repo.insert!(%Metas.State{ abbr: "NE", full: "Nebraska", country_code: "USA", tz_offset: -6, observes_dst: true })
Repo.get_by(Metas.State, abbr: "NV")
  || Repo.insert!(%Metas.State{ abbr: "NV", full: "Nevada", country_code: "USA", tz_offset: -8, observes_dst: true })
Repo.get_by(Metas.State, abbr: "NH")
  || Repo.insert!(%Metas.State{ abbr: "NH", full: "New Hampshire", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "NJ")
  || Repo.insert!(%Metas.State{ abbr: "NJ", full: "New Jersey", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "NM")
  || Repo.insert!(%Metas.State{ abbr: "NM", full: "New Mexico", country_code: "USA", tz_offset: -7, observes_dst: true })
Repo.get_by(Metas.State, abbr: "NY")
  || Repo.insert!(%Metas.State{ abbr: "NY", full: "New York", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "NC")
  || Repo.insert!(%Metas.State{ abbr: "NC", full: "North Carolina", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "ND")
  || Repo.insert!(%Metas.State{ abbr: "ND", full: "North Dakota", country_code: "USA", tz_offset: -6, observes_dst: true })
Repo.get_by(Metas.State, abbr: "OH")
  || Repo.insert!(%Metas.State{ abbr: "OH", full: "Ohio", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "OK")
  || Repo.insert!(%Metas.State{ abbr: "OK", full: "Oklahoma", country_code: "USA", tz_offset: -6, observes_dst: true })
Repo.get_by(Metas.State, abbr: "OR")
  || Repo.insert!(%Metas.State{ abbr: "OR", full: "Oregon", country_code: "USA", tz_offset: -8, observes_dst: true })
Repo.get_by(Metas.State, abbr: "PA")
  || Repo.insert!(%Metas.State{ abbr: "PA", full: "Pennsylvania", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "RI")
  || Repo.insert!(%Metas.State{ abbr: "RI", full: "Rhode Island", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "SC")
  || Repo.insert!(%Metas.State{ abbr: "SC", full: "South Carolina", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "SD")
  || Repo.insert!(%Metas.State{ abbr: "SD", full: "South Dakota", country_code: "USA", tz_offset: -7, observes_dst: true })
Repo.get_by(Metas.State, abbr: "TN")
  || Repo.insert!(%Metas.State{ abbr: "TN", full: "Tennessee", country_code: "USA", tz_offset: -6, observes_dst: true })
Repo.get_by(Metas.State, abbr: "TX")
  || Repo.insert!(%Metas.State{ abbr: "TX", full: "Texas", country_code: "USA", tz_offset: -6, observes_dst: true })
Repo.get_by(Metas.State, abbr: "UT")
  || Repo.insert!(%Metas.State{ abbr: "UT", full: "Utah", country_code: "USA", tz_offset: -7, observes_dst: true })
Repo.get_by(Metas.State, abbr: "VT")
  || Repo.insert!(%Metas.State{ abbr: "VT", full: "Vermont", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "VA")
  || Repo.insert!(%Metas.State{ abbr: "VA", full: "Virginia", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "WA")
  || Repo.insert!(%Metas.State{ abbr: "WA", full: "Washington", country_code: "USA", tz_offset: -8, observes_dst: true })
Repo.get_by(Metas.State, abbr: "WV")
  || Repo.insert!(%Metas.State{ abbr: "WV", full: "West Virginia", country_code: "USA", tz_offset: -5, observes_dst: true })
Repo.get_by(Metas.State, abbr: "WI")
  || Repo.insert!(%Metas.State{ abbr: "WI", full: "Wisconsin", country_code: "USA", tz_offset: -6, observes_dst: true })
Repo.get_by(Metas.State, abbr: "WY")
  || Repo.insert!(%Metas.State{ abbr: "WY", full: "Wyoming", country_code: "USA", tz_offset: -7, observes_dst: true })

# SEED SPORTS
Repo.get_by(Metas.Sport, abbr_gender: "XC")
  || Repo.insert!(%Metas.Sport{ abbr: "XC", full: "Cross Country", abbr_gender: "XC", full_gender: "Cross Country", is_numbered: false, is_meta: false })
Repo.get_by(Metas.Sport, abbr_gender: "GF")
  || Repo.insert!(%Metas.Sport{ abbr: "GF", full: "Golf", abbr_gender: "GF", full_gender: "Golf", is_numbered: false, is_meta: false })
Repo.get_by(Metas.Sport, abbr_gender: "TF")
  || Repo.insert!(%Metas.Sport{ abbr: "TF", full: "Track and Field", abbr_gender: "TF", full_gender: "Track and Field", is_numbered: false, is_meta: false })
Repo.get_by(Metas.Sport, abbr_gender: "CH")
  || Repo.insert!(%Metas.Sport{ abbr: "CH", full: "Cheer", abbr_gender: "CH", full_gender: "Cheer", is_numbered: false, is_meta: false })
Repo.get_by(Metas.Sport, abbr_gender: "BBB")
  || Repo.insert!(%Metas.Sport{ abbr: "BB", full: "Basketball", abbr_gender: "BBB", full_gender: "Boys Basketball", is_numbered: true, is_meta: false })
Repo.get_by(Metas.Sport, abbr_gender: "GBB")
  || Repo.insert!(%Metas.Sport{ abbr: "BB", full: "Basketball", abbr_gender: "GBB", full_gender: "Girls Basketball", is_numbered: true, is_meta: false })
Repo.get_by(Metas.Sport, abbr_gender: "VB")
  || Repo.insert!(%Metas.Sport{ abbr: "VB", full: "Volleyball", abbr_gender: "VB", full_gender: "Volleyball", is_numbered: true, is_meta: false })
Repo.get_by(Metas.Sport, abbr_gender: "FB")
  || Repo.insert!(%Metas.Sport{ abbr: "FB", full: "Football", abbr_gender: "FB", full_gender: "Football", is_numbered: true, is_meta: false })
Repo.get_by(Metas.Sport, abbr_gender: "STF")
  || Repo.insert!(%Metas.Sport{ abbr: "ST", full: "Staff", abbr_gender: "STF", full_gender: "Staff", is_numbered: false, is_meta: true })

# clean existing data
seeded_classes = [ Country, Location, LocationGroup, PanelProvider, TargetGroup ]
seeded_classes.each(&:delete_all)


# populate database with initial data
panel_providers = [
  { code: "TimeLetters" },
  { code: "AjaxNodes" },
  { code: "TimeNodes" },
]
panel_providers.each { |data| PanelProvider.create!(data) }

countries = [
]
countries.each { |data| Country.create!(data) }

locations = [
]
locations.each { |data| Location.create!(data) }

location_groups = [
]
location_groups.each { |data| LocationGroup.create!(data) }

countries = [
]

target_groups.each { |data| TargetGroup.create!(data) }

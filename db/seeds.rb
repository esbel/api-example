# clean existing data
seeded_classes = [ Country, Location, LocationGroup, PanelProvider, TargetGroup, User ]
seeded_classes.each(&:delete_all)


# populate database with initial data
panel_providers = [
  { code: "TimeLetters" },
  { code: "AjaxNodes" },
  { code: "TimeNodes" },
]
panel_providers.collect! { |data| PanelProvider.create!(data) }

countries = [
  { country_code: "BLZ", panel_provider_id: panel_providers[0].id },
  { country_code: "HND", panel_provider_id: panel_providers[1].id },
  { country_code: "SLV", panel_provider_id: panel_providers[2].id }
]
countries.collect! { |data| Country.create!(data) }

locations = [
  { name: "Belize City",      external_id: "", secret_code: "", country_id: countries[0].id },
  { name: "Belmopan",         external_id: "", secret_code: "", country_id: countries[0].id },
  { name: "San Ignacio",      external_id: "", secret_code: "", country_id: countries[0].id },
  { name: "Orange Walk Town", external_id: "", secret_code: "", country_id: countries[0].id },
  { name: "San Pedro Town",   external_id: "", secret_code: "", country_id: countries[0].id },
  { name: "Cirizak Tiwn",     external_id: "", secret_code: "", country_id: countries[0].id },
  { name: "Atlántida",        external_id: "", secret_code: "", country_id: countries[1].id },
  { name: "Choluteca",        external_id: "", secret_code: "", country_id: countries[1].id },
  { name: "Colón",            external_id: "", secret_code: "", country_id: countries[1].id },
  { name: "Comayagua",        external_id: "", secret_code: "", country_id: countries[1].id },
  { name: "Copán",            external_id: "", secret_code: "", country_id: countries[1].id },
  { name: "Cortés",           external_id: "", secret_code: "", country_id: countries[1].id },
  { name: "El Paraíso",       external_id: "", secret_code: "", country_id: countries[1].id },
  { name: "San Salvador",     external_id: "", secret_code: "", country_id: countries[2].id },
  { name: "Santa Ana",        external_id: "", secret_code: "", country_id: countries[2].id },
  { name: "Soyapango",        external_id: "", secret_code: "", country_id: countries[2].id },
  { name: "San Miguel",       external_id: "", secret_code: "", country_id: countries[2].id },
  { name: "Santa Tecla",      external_id: "", secret_code: "", country_id: countries[2].id },
  { name: "Mejicanos ",       external_id: "", secret_code: "", country_id: countries[2].id },
  { name: "Apopa",            external_id: "", secret_code: "", country_id: countries[2].id },
]
locations.collect! { |data| Location.create!(data) }

location_groups = [
  { name: "Cities in Belize", country_id: countries[0].id, panel_provider_id: panel_providers[0].id },
  { name: "Cities in Honduras", country_id: countries[1].id, panel_provider_id: panel_providers[1].id },
  { name: "Some other cities in El Salvador", country_id: countries[2].id, panel_provider_id: panel_providers[2].id },
  { name: "Some cities in El Salvador", country_id: countries[2].id, panel_provider_id: panel_providers[1].id }
]
location_groups.collect! { |data| LocationGroup.create!(data) }

location_groups[0].locations << locations.first(6)
location_groups[1].locations << locations[6..13]
location_groups[2].locations << locations[14..17]
location_groups[3].locations << locations[16..-1]

root_groups = [
  { name: "Group A", secret_code: "", country_id: countries[0].id, panel_provider_id: panel_providers[0].id },
  { name: "Group B", secret_code: "", country_id: countries[1].id, panel_provider_id: panel_providers[0].id },
  { name: "Group C", secret_code: "", country_id: countries[1].id, panel_provider_id: panel_providers[0].id },
  { name: "Group D", secret_code: "", country_id: countries[2].id, panel_provider_id: panel_providers[0].id }
]
root_groups.collect! { |data| TargetGroup.create!(data) }

children_groups = [
  { name: "Group A.0", secret_code: "", country_id: countries[0].id, panel_provider_id: panel_providers[0].id, parent_id: root_groups[0].id },
  { name: "Group B.1", secret_code: "", country_id: countries[1].id, panel_provider_id: panel_providers[1].id, parent_id: root_groups[1].id },
  { name: "Group C.2", secret_code: "", country_id: countries[1].id, panel_provider_id: panel_providers[2].id, parent_id: root_groups[2].id },
  { name: "Group D.3", secret_code: "", country_id: countries[2].id, panel_provider_id: panel_providers[2].id, parent_id: root_groups[3].id }
]
children_groups.collect! { |data| TargetGroup.create!(data) }

grandchildren_groups = [
  { name: "Group A.0.1", secret_code: "", country_id: countries[0].id, panel_provider_id: panel_providers[0].id, parent_id: children_groups[0].id },
  { name: "Group B.1.1", secret_code: "", country_id: countries[1].id, panel_provider_id: panel_providers[0].id, parent_id: children_groups[1].id },
  { name: "Group C.2.1", secret_code: "", country_id: countries[1].id, panel_provider_id: panel_providers[1].id, parent_id: children_groups[2].id },
  { name: "Group D.3.1", secret_code: "", country_id: countries[2].id, panel_provider_id: panel_providers[2].id, parent_id: children_groups[3].id }
]
grandchildren_groups.collect! { |data| TargetGroup.create!(data) }


User.create!(:password => "sample-password", email: "sample@example.com")

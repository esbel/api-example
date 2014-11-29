# clean existing data
seeded_classes = [ Country, Location, LocationGroup, PanelProvider, TargetGroup ]
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
locations.each { |data| Location.create!(data) }

location_groups = [
  { name: "Cities in Belize", country_id: countries[0].id, panel_provider_id: panel_providers[0].id }
  { name: "Cities in Honduras", country_id: countries[1].id, panel_provider_id: panel_providers[1].id }
  { name: "Some other cities in El Salvador", country_id: countries[2].id, panel_provider_id: panel_providers[2].id }
  { name: "Some cities in El Salvador", country_id: countries[2].id, panel_provider_id: panel_providers[1].id }
]
location_groups.each { |data| LocationGroup.create!(data) }

countries = [
]

target_groups.each { |data| TargetGroup.create!(data) }

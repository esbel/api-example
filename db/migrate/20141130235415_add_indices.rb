class AddIndices < ActiveRecord::Migration
  def change
    add_index :countries, :country_code
    add_index :countries, :panel_provider_id
    add_index :location_groups, :panel_provider_id
    add_index :location_groups, :country_id
    add_index :location_groups_locations, :location_id
    add_index :location_groups_locations, :location_group_id
    add_index :locations, :country_id
    add_index :panel_providers, :code
    add_index :target_groups, :parent_id
    add_index :target_groups, :country_id
    add_index :target_groups, :panel_provider_id
  end
end

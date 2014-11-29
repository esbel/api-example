class TargetGroup < ActiveRecord::Base
  begin :associations
    belongs_to :country
    belongs_to :panel_provider
  end

  begin :attributes
    acts_as_tree
  end

  begin :validations
    validate :name,
      presence: true
  end
end

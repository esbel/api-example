class PublicAPI < Grape::API
  format :json
  format :json

  helpers do
    def country
      @country ||= (Country.by_country_code(params[:country_code]).take) ||
        (raise ActiveRecord::RecordNotFound)
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    not_found_response = {
      "message" => "Not Found.",
      "status"  => 404,
    }
    rack_response(not_found_response.to_json, 404)
  end

  resources :locations do
    desc "get all locations in country indicated by :coutry_code"
    params do
      requires :country_code, type: String, desc: 'Three-letter country code'
    end
    get ":country_code", requirements: { country_code: /[A-Z]{3}/ } do
      @locations = LocationsByCountryQuery.new(country).call
    end
  end

  resources :target_groups do
    desc "get all target groups in country indicated by :coutry_code"
    params do
      requires :country_code, type: String, desc: 'Three-letter country code'
    end
    get ":country_code", requirements: { country_code: /[A-Z]{3}/ } do
      @target_groups = TargetGroupsByCountryQuery.new(country).call
    end
  end
end

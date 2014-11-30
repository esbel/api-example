class API < Grape::API
  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers

  helpers do
    def country
      @country ||= (Country.by_country_code(params[:country_code]).take) ||
        (raise ActiveRecord::RecordNotFound)
    end

    def target_group
      @target_group ||= country.target_groups.find(params[:target_group_id])
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


  desc "return price for given panel"
  params do
    requires :country_code,    type: String,  desc: 'Three-letter country code'
    requires :target_group_id, type: Integer, desc: 'TargetGroup identifier'
    requires :locations,       type: Array,   desc: 'An array of locations (e.g. {id: 123, panel_size: 300})'
  end
  post "evaluate_target", requirements: { country_code: /[A-Z]{3}/ } do
    @price = CalculatePrice.new(country, target_group, params[:locations]).call

    status 201
    { price: @price }
  end
end

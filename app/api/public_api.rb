class PublicAPI < Grape::API
  format :json

  helpers do
    def country
      @country ||= (Country.by_country_code(params[:country_code]).take) ||
        (raise ActiveRecord::RecordNotFound)
    end
  end

  resources :target_groups do
    desc "get all target groups in country indicated by :coutry_code"
    params do
      requires :country_code, type: String, desc: 'Three-letter country code'
    end
    get ":country_code", requirements: { country_code: /[A-Z]{3}/ } do
    end
  end

  resources :locations do
    desc "get all locations in country indicated by :coutry_code"
    params do
      requires :country_code, type: String, desc: 'Three-letter country code'
    end
    get ":country_code", requirements: { country_code: /[A-Z]{3}/ } do
    end
  end
end

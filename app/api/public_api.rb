class PublicAPI < Grape::API
  format :json

  helpers do
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
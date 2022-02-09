require 'rails_helper'

RSpec.describe "merchant API" do 
  it "renders all merchants" do 

    create_list(:merchant, 5)
    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(5)
    
    merchants[:data].each do |merchant|
      # expect(merchant).to have_key(:id)
      #how can i test the key?
      # expect(merchant[:attributes][:id]).to be_an(Integer)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end 
  end 

  it "can get one merchant by its id" do 
    id = create(:merchant).id 

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful

    expect(merchant[:data]).to have_key(:id)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end 

  it 'can find one merchant by name' do 
    
  end 
end 
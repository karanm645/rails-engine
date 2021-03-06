require 'rails_helper'

RSpec.describe "merchant API" do 
  describe "happy paths" do 
    it "renders all merchants" do 
      create_list(:merchant, 5)
      get '/api/v1/merchants'

      expect(response).to be_successful
      merchants = JSON.parse(response.body, symbolize_names: true)
      expect(merchants[:data].count).to eq(5)
      
      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
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
  end 

  describe 'sad path' do 
    it 'cant find a merchant' do 
      id = 0
      get "/api/v1/merchants/#{id}"
      body = JSON.parse(response.body, symbolize_names: true)
      
      expect(response.status).to eq(404)
    end 
  end 

  describe 'find merchant' do 
    describe 'happy path' do 
      it 'can find one merchant by name' do 
        merchants = create_list(:merchant, 20)
        dynamo = create(:merchant, name: "Dynamo")
        get "/api/v1/merchants/find?name=namo"

        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data][:id]).to eq("#{dynamo.id}")
      end 
    end 

    describe 'sad path' do 
      it 'cant find merchant by name' do 
        get "/api/v1/merchants/find?name=namo"
        body = JSON.parse(response.body, symbolize_names: true)
        
        expect(body[:data][:message]).to eq("Merchant not found")
      end 
    end 
  end 

  describe 'find quantity of merchants sorted by descending rev' do 
    
  end 
end 
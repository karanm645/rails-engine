require 'rails_helper'

RSpec.describe 'merchant items exposure' do 
  
  describe 'happy path' do 
    it "can get a merchants items" do 
      merchant = create(:merchant)
      create_list(:item, 10, merchant: merchant)
      items = merchant.items
      # id = create(:merchant).id
      get "/api/v1/merchants/#{merchant.id}/items"
      all_items = JSON.parse(response.body, symbolize_names: true)
      
      
      expect(response).to be_successful
      expect(items.count).to eq(10)
      
      all_items[:data].each do |item|
        
        # expect(merchant).to have_key(:id)
        #how can i test the key?
        # expect(merchant[:attributes][:id]).to be_an(Integer)
        
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)
        
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)
        
        expect(item[:attributes]).to have_key(:unit_price)
        # expect(item[:attributes][:unit_price]).to be_a(Integer)
      end 
    end 
    
  end 
  describe 'sad path' do 
    it 'cant find a merchant' do 
      id = 0
      get "/api/v1/merchants/#{id}/items"
      body = JSON.parse(response.body, symbolize_names: true)
      
      expect(response.status).to eq(404)
    end 
  end 
end 
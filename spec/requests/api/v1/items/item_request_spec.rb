require 'rails_helper'

RSpec.describe "item API" do 
  before :each do 
    @merchant = create(:merchant)
  end 

  describe 'happy paths' do 
    it "renders all items" do 
      create_list(:item, 10, merchant: @merchant)

      get '/api/v1/items'
      expect(response).to be_successful
      items = JSON.parse(response.body, symbolize_names: true)
      expect(items[:data].count).to eq(10)

      items[:data].each do |item|
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
      end 
    end 

    it "can get one item by its id" do 
      create_list(:item, 10, merchant: @merchant)
      item = Item.last

      get "/api/v1/items/#{item.id}"
      item = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      
      expect(item[:data]).to have_key(:id)

      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes][:name]).to be_a(String)
      
      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes][:description]).to be_a(String)
      
      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes][:unit_price]).to be_a(Float)
    end 

    it "can create a new item" do 
      create_list(:item, 10, merchant: @merchant)
      post "/api/v1/items", params: {
                      name: 'new item',
                      description: 'new description',
                      unit_price: 5.5,
                      merchant_id: @merchant.id
                    }
    
      item = JSON.parse(response.body, symbolize_names: true)
      new_item = Item.find(item[:data][:id])
      expect(response).to be_successful

      expect(item[:data][:attributes][:name]).to eq(new_item[:name])
      expect(item[:data][:attributes][:description]).to eq(new_item[:description])
      expect(item[:data][:attributes][:unit_price]).to eq(new_item[:unit_price])
    end 

    it "can destroy an item" do 
      item = create(:item, merchant: @merchant)

      expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)
      expect(response).to be_successful
      expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end 

    it "can update an existing item" do 
      id = create(:item, merchant: @merchant).id
      previous_name = Item.last.name 
      item_params = { name: 'updated item',
        description: 'updated description',
        unit_price: 5,
        merchant_id: @merchant.id
      }
      patch "/api/v1/items/#{id}", params: item_params    
    
      item = Item.find_by(id: id)

      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq("updated item")
    end 
  end 

  describe 'sad path' do 

    it "renders an error message for bad id" do 
      id = 0
      get "/api/v1/items/#{id}"
      body = JSON.parse(response.body, symbolize_names: true)
      
      expect(response.status).to eq(404)
    end 
  end 

  describe 'find all items' do 
    describe 'happy path' do 
      it "find all items based on search criteria" do 
        items = create_list(:item, 10, merchant: @merchant)
        necklace = create(:item, name: "Necklace", merchant: @merchant)
        necktie = create(:item, name: "Neck Tie", merchant: @merchant)
        get "/api/v1/items/find_all?name=neck"

        body = JSON.parse(response.body, symbolize_names: true)
      end 
    end 
  end 

  describe 'sad path' do 
    it 'cant find a merchant by id' do 
      id = 0
      get "/api/v1/merchants/#{id}/items"
      body = JSON.parse(response.body, symbolize_names: true)
      
      expect(response.status).to eq(404)
    end 
  end 
end 
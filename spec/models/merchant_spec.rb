require 'rails_helper'

RSpec.describe Merchant do
  describe 'relations' do 
    it { should have_many :items }
  end 

  describe '::find_merchant' do 
    it ' finds a merchant by search query' do 
      merchants = create_list(:merchant, 15)
      dynamo = create(:merchant, name: "Dynamo")

      expect(Merchant.find_merchant("namo")).to eq(dynamo)
    end 
  end 

  describe '::top_merchants_by_revenue' do 
    it 'lists merchants by most revenue' do 
      merchants = create_list(:merchant, 15)
      
    end 
  end 
end 

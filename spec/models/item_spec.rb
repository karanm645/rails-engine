require 'rails_helper'

RSpec.describe Item do
  it { should belong_to :merchant }

  describe '::find_items' do 
    it ' finds all items matching search query' do 
      @merchant = create(:merchant)
      items = create_list(:item, 20, merchant: @merchant)
      necklace = create(:item, name: "Necklace", merchant: @merchant)
      necktie = create(:item, name: "Neck Tie", merchant: @merchant)

      expect(Item.find_items("neck")).to eq([necklace, necktie])
    end 
  end 
end 
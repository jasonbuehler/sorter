require 'spec_helper'

describe ListsController do
  describe 'index' do
    it "works" do
      get :index
      response.should be_success
    end

    it "sets lists" do
      List.create name: "My list", list_items_attributes: [
          number: 4294967296
      ]
      get :index
      assigns(:lists).should be_present
    end
  end

  describe 'generate' do
    it "creates a list" do
      expect {
        get :generate
      }.to change(List, :count).by(1)
    end
    it "returns json" do
      get :generate
      response.header['Content-Type'].should include 'application/json'
    end
    it "returns list_items" do
      get :generate
      list_items = JSON.parse(response.body)
      list_items.should be_present
      list_items.size.should == 20
    end
  end

  describe 'sort' do
    let(:list) { [20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1] }
    it "sorts a list" do
      post :sort, list: list
      JSON.parse(response.body).should == list.sort
    end
    it "saves the sorted list" do
      expect {
        post :sort, list: list
      }.to change(List, :count).by(1)
      List.last.list_items.map(&:number).should == list.sort
    end
  end
end

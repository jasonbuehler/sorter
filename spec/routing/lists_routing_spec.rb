require 'spec_helper'

describe 'list routes' do
  it 'routes to index' do
    {get: '/lists'}.should route_to("lists#index")
  end

  it 'routes to generate' do
    {get: 'lists/generate'}.should route_to("lists#generate")
  end

  it "routes to sort" do
    {post: 'lists/sort'}.should route_to("lists#sort")
  end
end
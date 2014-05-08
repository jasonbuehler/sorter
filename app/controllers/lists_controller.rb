class ListsController < ApplicationController
  LIST_GENERATE_N = 50
  def index
    @ls = List.all.order("id desc");
  end

  def generate
    o :generate
  end

  def sort
    o :sort, params[:list]
  end

  def reverse
    @ls = List.all
    o :reverse, params[:list]
  end

  def o action, list = []
    case action
      when :generate
        lis = []
        20.times do |i|
          lis << {number: rand(20)}
        end
        l = List.create list_items_attributes: lis

        render json: l.list_items.map(&:number)
      when :sort
        Rails.logger.warn(list)
        list = list.map{|i| i.to_i}.sort
        l = List.create
        list.each do |li|
          Rails.logger.warn(li)
          l.list_items.create(number: li)
        end
        Rails.logger.warn(list)
        render json: l.list_items.map(&:number)
      when :reverse
        l1 = list.map{|i| i.to_i}.sort.reverse
        l2 = List.create
        l1.each do |li|
          l2.list_items.create(number: li)
        end
        render json: l2.list_items.map(&:number)
    end
  end
end

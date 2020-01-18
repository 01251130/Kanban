class CardController < ApplicationController
  before_action :set_card, only: %i(show edit update destroy)

  def new
    @card = Card.new
    @list = List.find(params[:list_id])
  end

  def create
    @card = Card.new(card_params)
    @card.order = Card.where(list_id: params[:list_id]).maximum(:order).to_i + 1    # Listにカードが存在しない場合、nilが返却されるので問題なく動くようにto_iする
    if @card.save
      redirect_to :root
    else
      render action: :new
    end
  end

  def show
  end

  def edit
    @lists = List.where(user: current_user)
    @cards = Card.where(list_id: params[:list_id]).order(:order)
  end

  def update
    # リストに変更があった場合、orderも更新
    if params[:list_id] != card_params[:list_id]
      @card.order = Card.where(list_id: card_params[:list_id]).maximum(:order).to_i + 1    # Listにカードが存在しない場合、nilが返却されるので問題なく動くようにto_iする
    # 並び順に変更があった場合
    elsif @card.order != card_params[:order]
      order_after = card_params[:order].to_i
      # 変更前のorder > 変更後のorder
      if @card.order > order_after
        (order_after..@card.order-1).each {|n| 
          @card_order = Card.find_by(list_id: params[:list_id], order: n)
          @card_order.update_attributes(order: n+1)
        }
      # 変更前のorder < 変更後のorder
      elsif @card.order < order_after
        (@card.order+1..order_after).each {|n| 
          @card_order = Card.find_by(list_id: params[:list_id], order: n)
          @card_order.update_attributes(order: n-1)
        }
      end
      @card.order = card_params[:order]
    end

    if @card.update_attributes(card_params)
      redirect_to :root
    else
      render action: :edit
    end
  end

  def destroy
    # 削除されたカードよりorderが大きいカードは、orderを-1する
    cards = Card.where(list_id: params[:list_id], order: @card.order+1..Float::INFINITY)
    cards.each { |card|
      card.update_attributes(order: card.order-1)
    }
    @card.destroy
    redirect_to :root
  end

  private
    def card_params
      params.require(:card).permit(:title, :memo, :list_id, :order)
    end

    def set_card
      @card = Card.find(params[:id])
    end

end

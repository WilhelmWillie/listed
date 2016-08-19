class ItemsController < ApplicationController
  # Harnesses the force to create a new item and attach it to the list
  def create
    @item = Item.new(item_params)
    @item.list = List.find(params[:list_id])
    @item.order = @item.list.items.count

    if @item.save
      redirect_to @item.list, notice: 'Item added succesfully'
    else
      redirect_to @item.list, notice: 'Error'
    end
  end

  # Brute force update a list item using complex dataspring sector data 
  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      redirect_to @item.list, notice: 'Item updated'
    else
      redirect_to @item.list, notice: 'Item updated'
    end
  end

  # DESTROY THE INFIDEL ITEM
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to @item.list
  end

  # Used for swapping items 
  def swap
    @item_a = Item.find(params[:item_id])
    @item_b = Item.find(params[:swap_id])

    b_order = @item_b.order
    @item_b.update(order: @item_a.order)
    @item_a.update(order: b_order)

    render json: { 'message' => 'Item succesfully swapped' }
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :description, :order)
    end
end

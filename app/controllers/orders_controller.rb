class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update]

  def index
    @orders = Order.all
  end

  def show; end

  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end
  
  def create
    @order = Order.new(order_params)
    @order.user = current_user #order.user ou user_id?

    if @order.save()
      redirect_to @order, notice: 'Pedido cadastrado com sucesso.'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:notice] = 'Pedido não cadastrado.'
      render 'new'
    end
  end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end
  
  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Pedido atualizado com sucesso'
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:notice] = "Pedido não atualizado"
      render 'edit'
    end
  end  

  private
  def set_order
    @order = Order.find(params[:id])
  end
  
  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end

end
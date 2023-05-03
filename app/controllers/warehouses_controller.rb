class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def new
  end

  # def create
  #   @object = Object.new(params[:object])
  #   if @object.save
  #     flash[:success] = "Object successfully created"
  #     redirect_to @object
  #   else
  #     flash[:error] = "Something went wrong"
  #     render 'new'
  #   end
  # end
  
  def create
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, :zip, :area)

    w = Warehouse.new(warehouse_params)
    w.save()

    redirect_to root_path, notice: 'Galpão cadastrado com sucesso.'
  end

end
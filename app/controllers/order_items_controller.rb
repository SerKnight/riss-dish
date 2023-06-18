class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin, only: [:index, :destroy]

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /order_items
  def index
    @pagy, @order_items = pagy(OrderItem.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @order_items
  end

  # GET /order_items/1 or /order_items/1.json
  def show
  end

  # GET /order_items/new
  def new
    @order_item = OrderItem.new

    # Uncomment to authorize with Pundit
    # authorize @order_item
  end

  # GET /order_items/1/edit
  def edit
  end

  # POST /order_items or /order_items.json
  def create
    @order_item = OrderItem.new(order_item_params)

    # Uncomment to authorize with Pundit
    # authorize @order_item

    respond_to do |format|
      if @order_item.save
        format.html { redirect_to @order_item, notice: "Order item was successfully created." }
        format.json { render :show, status: :created, location: @order_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_items/1 or /order_items/1.json
  def update
    respond_to do |format|
      if @order_item.update(order_item_params)
        format.html { redirect_to @order_item, notice: "Order item was successfully updated." }
        format.json { render :show, status: :ok, location: @order_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_items/1 or /order_items/1.json
  def destroy
    @order_item.destroy
    respond_to do |format|
      format.html { redirect_to order_items_url, status: :see_other, notice: "Order item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order_item
    @order_item = OrderItem.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @order_item
  rescue ActiveRecord::RecordNotFound
    redirect_to order_items_path
  end

  # Only allow a list of trusted parameters through.
  def order_item_params
    params.require(:order_item).permit(:order_id, :product_id, :quantity, :price)

    # Uncomment to use Pundit permitted attributes
    # params.require(:order_item).permit(policy(@order_item).permitted_attributes)
  end
end

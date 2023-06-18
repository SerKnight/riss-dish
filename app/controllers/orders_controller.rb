class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin, only: [:index, :destroy]

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /orders
  def index
    @pagy, @orders = pagy(Order.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @orders
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new

    # Uncomment to authorize with Pundit
    # authorize @order
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    # Uncomment to authorize with Pundit
    # authorize @order

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, status: :see_other, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @order
  rescue ActiveRecord::RecordNotFound
    redirect_to orders_path
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:slot_id, :user_id)

    # Uncomment to use Pundit permitted attributes
    # params.require(:order).permit(policy(@order).permitted_attributes)
  end
end

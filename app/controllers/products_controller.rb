class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /products
  def index
    @pagy, @products = pagy(Product.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @products
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new

    # Uncomment to authorize with Pundit
    # authorize @product
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    @product.tags = params[:product][:tags].split(',').map(&:strip)
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        @product.tags = params[:product][:tags].split(',').map(&:strip)
        @product.save
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, status: :see_other, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @product
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:title, :price, :description, :ingredients, :tags, :main_image, images: [])

    # Uncomment to use Pundit permitted attributes
    # params.require(:product).permit(policy(@product).permitted_attributes)
  end
end

class DaysController < ApplicationController
  before_action :set_day, only: [:show, :edit, :update, :destroy]

  # Uncomment to enforce Pundit authorization
  # after_action :verify_authorized
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # GET /days
  def index
    @pagy, @days = pagy(Day.sort_by_params(params[:sort], sort_direction))

    # Uncomment to authorize with Pundit
    # authorize @days
  end

  # GET /days/1 or /days/1.json
  def show
  end

# GET /days/new
  def new
    @day = Day.new

    # Uncomment to authorize with Pundit
    # authorize @day
  end

  # GET /days/1/edit
  def edit
  end

  # POST /days or /days.json
  def create
    @day = Day.new(day_params)
    # Uncomment to authorize with Pundit
    # authorize @day

    respond_to do |format|
      if @day.save
        handle_day_products
        format.html { redirect_to @day, notice: "Day was successfully created." }
        format.json { render :show, status: :created, location: @day }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /days/1 or /days/1.json
  def update
    respond_to do |format|
      if @day.update(day_params)
        handle_day_products

        format.html { redirect_to @day, notice: "Day was successfully updated." }
        format.json { render :show, status: :ok, location: @day }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @day.errors, status: :unprocessable_entity }
      end
    end
  end

  def handle_day_products
    @day.day_products.destroy_all
    product_ids = params[:day][:product_ids].reject(&:blank?) 
    product_ids.each do |product_id|
      @day.day_products.create(product_id: product_id)
    end
  end

  # DELETE /days/1 or /days/1.json
  def destroy
    @day.day_products.destroy_all
    @day.destroy
    respond_to do |format|
      format.html { redirect_to days_url, status: :see_other, notice: "Day was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_day
    @day = Day.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @day
  rescue ActiveRecord::RecordNotFound
    redirect_to days_path
  end

  # Only allow a list of trusted parameters through.
  def day_params
    params.require(:day).permit(:description, :date, :is_locked, product_ids: [])
    # Uncomment to use Pundit permitted attributes
    # params.require(:day).permit(policy(@day).permitted_attributes)
  end
end

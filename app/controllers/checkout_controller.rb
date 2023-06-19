class CheckoutController < ApplicationController
  before_action :set_day, only: [:slots]
  # before_action :authenticate_admin, except: [:calendar, :meals]
  
  def fetch_days(start_date, end_date, current_date = DateTime.now, fallback_days_count = 4)
    days = Day.where(date: start_date..end_date, is_locked: false)
  
    if days.empty?
      if current_date.month == start_date.month && current_date.year == start_date.year
        # if the current month is the one requested and there are no meals, show the next fallback_days_count days with meals
        days = Day.order(:date).limit(fallback_days_count)
        @upcoming_meal_copy = "No meals scheduled for #{start_date.strftime('%B')} - Next #{fallback_days_count} upcoming meals"
      else
        # if the date range is for a future month, don't select any days
        days = Day.none
        @upcoming_meal_copy = "No meals scheduled for #{start_date.strftime('%B')} :( Check back soon"
        
      end
    else
      @upcoming_meal_copy = "Upcoming #{start_date.strftime('%B')} Meals"
    end
  
    days
  end
  
  def calendar
    @current_month = (params[:month] || Date.today.month).to_i
    @current_year = Date.today.year
    @days_in_month = Time.days_in_month(@current_month, @current_year)
    @start_date = Date.new(@current_year, @current_month, 1)
    @end_date = @start_date.end_of_month

    @days = fetch_days(@start_date, @end_date, Date.today)
    @pagy, @days = pagy(@days.sort_by_params(params[:sort], sort_direction))
  end

  def customize
    @day = Day.where("DATE(date) = ?", params[:date]).first
  
    total_completed_orders = Order.where(slot_id: @day.slots.pluck(:id), completed: true).count
    total_available_slots = @day.slots.sum(:available_additions)
  
    if total_completed_orders < total_available_slots
      @order = Order.create(slot: @day.slots.sample, user: current_user)
    else
      # Handle the case when no slots are available
      # You can raise an error, redirect, or display an appropriate message to the user
      redirect_to '/checkout/calendar', notice: "Sorry, but the orders for #{@day.date.strftime("%Y-%m-%d")} have just reached capacity"

    end
  end  

  def process_customization
    @order = Order.find(params[:order_id])
    
    params[:product].each do |product_id, product_data|
      next if product_data[:quantity].to_i <= 0

      @order.order_items.create!(
        product_id: product_id,
        quantity: product_data[:quantity],
        price: Product.find(product_id).price * product_data[:quantity].to_i,
        comments: product_data[:comments]
      )
    end

    @order.update(tupperware_charge: params[:tupperware_charge], subtotal: params[:subtotal], tax: params[:tax], total: params[:total])

    redirect_to payment_path(date: params[:date], order_id: @order.id)
  end

  def payment
    @day = Day.where("DATE(date) = ?", params[:date]).first
    @order = Order.create(slot: @day.slots.sample, user: current_user)
  end

  def set_day
    param_date = params[:day].to_datetime
    @day = Day.where("extract(year from date) = ? AND extract(month from date) = ? AND extract(day from date) = ?", param_date.year, param_date.month, param_date.day).first

    redirect_to "/", alert: "Day has been locked, please select another." if @day.is_locked?
    # authorize @day
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  private

  def checkout_params
    product_params = params.require(:checkout).fetch(:product, {})
    product_params.each { |id, product| product.permit! }
    
    params.require(:checkout).permit(
      :tupperware_charge,
      :subtotal,
      :tax,
      :total,
      :comments,
      :date,
      :order_id,
    ).merge(product: product_params)
  end
  
end

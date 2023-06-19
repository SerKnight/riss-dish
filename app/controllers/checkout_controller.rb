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

  def slots
    @current_month = (params[:month] || Date.today.month).to_i
    @current_year = Date.today.year
    @days_in_month = Time.days_in_month(@current_month, @current_year)
    
    @start_date = Date.new(@current_year, @current_month, 1)
    @end_date = @start_date.end_of_month
    
    current_day = Date.parse(params[:day])
    current_month = current_day.month
    current_year = current_day.year
    days_in_month = Time.days_in_month(current_month, current_year)

    
    @start_date = Date.new(current_year, current_month, 1)
    @end_date = @start_date.end_of_month

    # create a range from 2 days before to 2 days after the given date
    date = Date.parse(params[:day])
    date_range = (date - 1.days)..(date + 2.days)
    @day = Day.where(date: date_range).first

    @first_slot_window, @second_slot_window = @day.slots.partition do |slot|
      slot.delivery_start_time.hour == 22
    end

  end

  def meals
    @slot = Slot.find(params[:slot_id])
  end

  def set_day
    param_date = params[:day].to_datetime
    @day = Day.where("extract(year from date) = ? AND extract(month from date) = ? AND extract(day from date) = ?", param_date.year, param_date.month, param_date.day).first

    redirect_to "/", alert: "Day has been locked, please select another." if @day.is_locked?
    # authorize @day
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end

module Admin
  class DaysController < Admin::ApplicationController

    def update
      if requested_resource.update(resource_params)
        handle_day_products
        redirect_to(
          [namespace, requested_resource],
          notice: translate_with_resource("update.success"),
        )
      else
        render :edit, locals: {
          page: Administrate::Page::Form.new(dashboard, requested_resource),
        }
      end
    end

    def create
      resource = resource_class.new(resource_params)

      if resource.save
        handle_day_products
        redirect_to(
          [namespace, resource],
          notice: translate_with_resource("create.success"),
        )
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }
      end
    end

    def handle_day_products
      requested_resource.day_products.destroy_all
      if !params[:day][:product_ids].nil?
        product_ids = params[:day][:product_ids].reject(&:blank?)
        product_ids.each do |product_id|
          requested_resource.day_products.create(product_id: product_id)
        end
      end
    end

  end
end

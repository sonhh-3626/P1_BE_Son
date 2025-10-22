class Api::V1::OrdersController < ApplicationController
  after_action :send_order_confirmation_email, only: %i(create)

  # POST /api/v1/orders
  def create
    unless params[:items].is_a?(Array) && params[:items].present?
      return render json: { error: "Order items are missing or invalid" }, status: :unprocessable_entity
    end

    ActiveRecord::Base.transaction do
      user = current_user || User.second

      @order = Order.create!(
        user: user,
        subtotal: params[:subtotal],
        applied_discount: params[:appliedDiscount],
        final_total: params[:finalTotal],
        is_free_shipping: params[:isFreeShipping],
        order_date: params[:orderDate]
      )

      @order.create_billing_detail!(billing_detail_params)

      params[:items].each do |item|
        unless item[:id].present? && item[:quantity].present? && item[:price].present?
          raise ActiveRecord::RecordInvalid.new(OrderItem.new), "Invalid item data: #{item.inspect}"
        end

        product = Product.find(item[:id])
        @order.order_items.create!(
          product: product,
          quantity: item[:quantity],
          price: item[:price]
        )
      end

      render json: { message: "Order created successfully", order_id: @order.id }, status: :created
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: "An unexpected error occurred: #{e.message}" }, status: :internal_server_error
  end

  # GET /api/v1/orders
  def index
    orders = Order.includes(:billing_detail, order_items: :product)

    # Search
    if params[:q].present?
      search_term = "%#{params[:q].downcase}%"
      orders = orders.where("CAST(orders.id AS TEXT) LIKE :search OR CAST(orders.user_id AS TEXT) LIKE :search", search: search_term)
    end

    # Sorting
    sort_column = params[:_sort] == 'orderDate' ? 'created_at' : (params[:_sort] == 'finalTotal' ? 'final_total' : 'created_at')
    sort_order = params[:_order] == 'asc' ? :asc : :desc
    orders = orders.order(sort_column => sort_order)

    # Pagination
    page = (params[:_page] || 1).to_i
    limit = (params[:_limit] || 10).to_i
    offset = (page - 1) * limit

    total_count = orders.count
    paginated_orders = orders.limit(limit).offset(offset)

    response.headers['x-total-count'] = total_count.to_s

    render json: paginated_orders.as_json(
      include: {
        billing_detail: {},
        order_items: {
          include: { product: { include: :product_images, methods: [:image_urls], except: [:img_url] } }
        }
      },
      except: [:updated_at]
    )
  end

  # GET /api/v1/orders/:id
  def show
    order = Order.includes(:billing_detail, order_items: :product).find(params[:id])
    render json: order.as_json(
      include: {
        billing_detail: {},
        order_items: {
          include: { product: { include: :product_images, methods: [:imageUrls] } }
        },
      },
      except: [:updated_at]
    )
  end

  # PATCH /api/v1/orders/:id/update_status
  def update_status
    @order = Order.find(params[:id])

    if @order.update(status: params[:status])
      render json: {
        message: "Order status updated successfully",
        status: @order.status_text
      }
    else
      render json: { error: @order.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def billing_detail_params
    params.require(:billingDetails).permit(
      :first_name, :last_name, :company_name,
      :country_region, :street_address, :apartment_suite, :town_city,
      :state, :zip_code, :phone, :email, :create_account,
      :ship_to_a_different_address, :order_notes
    )
  end

  def send_order_confirmation_email
      OrderMailer.order_confirmation(@order).deliver_later
  end
end

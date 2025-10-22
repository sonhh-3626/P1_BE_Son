class Api::V1::ProductsController < ApplicationController
  def index
    products = Product.includes(:category, :product_images)
    render json: products.as_json(
      include: {
        category: { only: [:id, :name, :slug] },
      },
      methods: %i(imageUrls category),
    )
  end

  def show
    product = Product.includes(:reviews, :category, :product_images).find_by id: params[:id]
    render json: product.as_json(
      include: {
        category: { only: [:id, :name] },
      },
      methods: %i(imageUrls reviewCount),
    )
  end

  # /api/v1/products/:id/get_reviews
  def get_reviews
    product = Product.find_by(id: params[:id])

    if product.nil?
      render json: { error: "Product not found" }, status: :not_found
      return
    end

    reviews = product.reviews.includes(:user)

    render json: reviews.as_json(
      only: [:id, :rating, :comment, :created_at],
      include: {
        user: { only: [:id, :username] }
      }
    )
  end
end

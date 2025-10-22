require "faker"

puts "🧹 Xoá dữ liệu cũ..."
OrderItem.delete_all
BillingDetail.delete_all
Order.delete_all
Review.delete_all
ProductImage.delete_all
Product.delete_all
Category.delete_all
Coupon.delete_all
User.delete_all

puts "👤 Tạo người dùng..."
admin = User.create!(
  username: "admin",
  password: "123456",
  email: "admin@example.com",
  role: "admin",
  first_name: "Admin",
  last_name: "User",
  country_region: "Vietnam",
  street_address: "123 Lê Lợi",
  town_city: "Hà Nội",
  state: "HN",
  zip_code: "10000",
  phone: "0123456789"
)

customer = User.create!(
  username: "nguyenvana",
  password: "123456",
  email: "customer@example.com",
  role: "customer",
  first_name: "Nguyen",
  last_name: "Van A",
  country_region: "Vietnam",
  street_address: "456 Trần Hưng Đạo",
  town_city: "HCM",
  state: "HCM",
  zip_code: "70000",
  phone: "0987654321"
)

puts "🥦 Tạo danh mục và sản phẩm về thực phẩm..."

fruits_vegetables = Category.create!(
  name: "Fruits & Vegetables",
  slug: "fruits-vegetables",
  img_url: "https://placehold.co/400x400?text=Fruits+%26+Vegetables"
)

baby_pregnancy = Category.create!(
  name: "Baby & Pregnancy",
  slug: "baby-pregnancy",
  img_url: "https://placehold.co/400x400?text=Baby+%26+Pregnancy"
)

beverages = Category.create!(
  name: "Beverages",
  slug: "beverages",
  img_url: "https://placehold.co/400x400?text=Beverages"
)

meats_seafood = Category.create!(
  name: "Meats & Seafood",
  slug: "meats-seafood",
  img_url: "https://placehold.co/400x400?text=Meats+%26+Seafood"
)

biscuits_snacks = Category.create!(
  name: "Biscuits & Snacks",
  slug: "biscuits-snacks",
  img_url: "https://placehold.co/400x400?text=Biscuits+%26+Snacks"
)

breads_bakery = Category.create!(
  name: "Breads & Bakery",
  slug: "breads-bakery",
  img_url: "https://placehold.co/400x400?text=Breads+%26+Bakery"
)

breakfast_dairy = Category.create!(
  name: "Breakfast & Dairy",
  slug: "breakfast-dairy",
  img_url: "https://placehold.co/400x400?text=Breakfast+%26+Dairy"
)

frozen_foods = Category.create!(
  name: "Frozen Foods",
  slug: "frozen-foods",
  img_url: "https://placehold.co/400x400?text=Frozen+Foods"
)

grocery_staples = Category.create!(
  name: "Grocery & Staples",
  slug: "grocery-staples",
  img_url: "https://placehold.co/400x400?text=Grocery+%26+Staples"
)

healthcare = Category.create!(
  name: "Healthcare",
  slug: "healthcare",
  img_url: "https://placehold.co/400x400?text=Healthcare"
)

household_needs = Category.create!(
  name: "Household Needs",
  slug: "household-needs",
  img_url: "https://placehold.co/400x400?text=Household+Needs"
)

# --- Con ---
fresh_fruits = Category.create!(
  name: "Fresh Fruits",
  slug: "fresh-fruits",
  img_url: "https://placehold.co/400x400?text=Fresh+Fruits",
  parent: fruits_vegetables
)

fresh_vegetables = Category.create!(
  name: "Fresh Vegetables",
  slug: "fresh-vegetables",
  img_url: "https://placehold.co/400x400?text=Fresh+Vegetables",
  parent: fruits_vegetables
)

baby_food = Category.create!(
  name: "Baby Food",
  slug: "baby-food",
  img_url: "https://placehold.co/400x400?text=Baby+Food",
  parent: baby_pregnancy
)

diapers = Category.create!(
  name: "Diapers",
  slug: "diapers",
  img_url: "https://placehold.co/400x400?text=Diapers",
  parent: baby_pregnancy
)

categories = [
  fresh_fruits, fresh_vegetables,
  baby_food, diapers,
  beverages, meats_seafood, biscuits_snacks, breads_bakery,
  breakfast_dairy, frozen_foods, grocery_staples, healthcare, household_needs
]

image_urls = [
  "https://picsum.photos/id/237/400/300",
  "https://picsum.photos/id/238/400/300",
  "https://picsum.photos/id/1/400/300"
]

30.times do
  name = Faker::Commerce.product_name
  category = categories.sample
  product = Product.create!(
    name: name,
    description: Faker::Food.description,
    price: Faker::Commerce.price(range: 1.0..50.0),
    discount_percentage: [0, 5, 10, 15].sample,
    stock_quantity: rand(20..200),
    rating: 0,
    product_type: Product.product_types.keys.sample,
    in_stock: true,
    on_sale: [true, false].sample,
    category: categories.sample
  )

  ProductImage.create!(
    product: product,
    image_url: image_urls[0]
  )

  ProductImage.create!(
    product: product,
    image_url: image_urls[1]
  )

  ProductImage.create!(
    product: product,
    image_url: image_urls[2]
  )

  Review.create!(
    user: customer,
    product: product,
    rating: rand(2..5),
    comment: [
      "Sản phẩm #{product.name} rất tốt, giao hàng nhanh.",
      "Hàng chất lượng, đúng mô tả.",
      "Giá hợp lý, sẽ mua lại lần sau.",
      "Đóng gói cẩn thận, rất hài lòng.",
      "#{product.name} đáng tiền, khuyên dùng!"
    ].sample
  )

  Review.create!(
    user: customer,
    product: product,
    rating: rand(2..5),
    comment: [
      "Sản phẩm #{product.name} rất tốt, giao hàng nhanh.",
      "Hàng chất lượng, đúng mô tả.",
      "Giá hợp lý, sẽ mua lại lần sau.",
      "Đóng gói cẩn thận, rất hài lòng.",
      "#{product.name} đáng tiền, khuyên dùng!"
    ].sample
  )
end

puts "✅ Đã sinh 30 sản phẩm ngẫu nhiên!"

puts "🖼️ Thêm ảnh sản phẩm thực phẩm..."

puts "⭐ Thêm đánh giá sản phẩm thực phẩm..."

puts "🍽️ Tạo đơn hàng thực phẩm mẫu..."

order_food = Order.create!(
  user: customer,
  is_free_shipping: true,
  order_date: Time.current,
  status: 0,
)

BillingDetail.create!(
  order: order_food,
  first_name: "Nguyen",
  last_name: "Thi B",
  company_name: "",
  country_region: "Vietnam",
  street_address: "789 Nguyễn Huệ",
  town_city: "Huế",
  state: "TT-Huế",
  zip_code: "53000",
  phone: "0901234567",
  email: "customer2@example.com",
  create_account: false,
  ship_to_a_different_address: false
)

OrderItem.create!(order: order_food, product: Product.first, quantity: 3, price: Product.first.price)
OrderItem.create!(order: order_food, product: Product.second, quantity: 1, price: Product.second.price)

order_food.save!

puts "✅ Seed dữ liệu hoàn tất!"

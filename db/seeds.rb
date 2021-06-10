# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
free_plan = Plan.find_or_create_by(name: "Free", box_limit: 1, stripe_product_id: "prod_JQNMf5VXOsJQRv")
moderate_plan = Plan.find_or_create_by(name: "Moderate", box_limit: 5, stripe_product_id: "prod_JOlsk2Up4koGKV")
unlimited_plan = Plan.find_or_create_by(name: "Unlimited", box_limit: 0, stripe_product_id: "prod_JOlt7J8RjVQ6pW")

Price.find_or_create_by(currency: "usd", amount: 0, interval: "month", stripe_price_id: "price_1InWgGDRun2Qs8KlsqUzbY8J", plan:free_plan)
Price.find_or_create_by(currency: "usd", amount: 2500, interval: "month", stripe_price_id: "price_1IlyavDRun2Qs8KlSLZUQgkc", plan:moderate_plan)
Price.find_or_create_by(currency: "usd", amount: 5000, interval: "month", stripe_price_id: "price_1IlybsDRun2Qs8KlCKwMRR8z", plan:unlimited_plan)

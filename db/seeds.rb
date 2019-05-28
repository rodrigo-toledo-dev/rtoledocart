require 'json'
products_file = File.read(Rails.root.join('db','initial_assets','products.json'))
Product.transaction do
  begin
    JSON.parse(products_file).each do |product_in_json|
      product = Product.new({
        ref_id: product_in_json['id'],
        name: product_in_json['name'],
        price: product_in_json['price'],
        score: product_in_json['score']
      })
      product.save!
      product.image.attach(io: File.open(Rails.root.join('db','initial_assets', product_in_json['image'])), filename: product_in_json['image'])
    end
  rescue => error
    puts error.message
  end
end
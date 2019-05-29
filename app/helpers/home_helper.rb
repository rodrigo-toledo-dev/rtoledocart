module HomeHelper
  def orders_for_products
    {
      t('home.index.order.by_name') => :name,
      t('home.index.order.by_score') => :score,
      t('home.index.order.by_price') => :price
    }
  end
  
end

 def find_item_by_name_in_collection(name, collection)
  counter = 0
  while counter < collection.length do
    collection[counter]
    if collection[counter][:item] == name
      return collection[counter]
    else nil
    end
    counter += 1
  end
end

def consolidate_cart(cart)
  new_cart = []
  item_index = 0
  while item_index < cart.length do
    new_item = find_item_by_name_in_collection(cart[item_index][:item], new_cart)
    if new_item != nil
      new_item[:count] += 1
    else new_item = {
      :item => cart[item_index][:item],
      :price => cart[item_index][:price],
      :clearance => cart[item_index][:clearance],
      :count => 1
    }
    new_cart << new_item
    end
    item_index += 1
  end
  new_cart
end

#DON'T BE SCARED DON'T BE SCARED DON'T BE SCARED
#drink your water. you're fine. <3
def apply_coupons(cart, coupons)
  coupon_index = 0
  while coupon_index < coupons.length do
    cart_item = find_item_by_name_in_collection(coupons[coupon_index][:item], cart)
    item_applied = "#{coupons[coupon_index][:item]} W/COUPON"
    item_with_coupon = find_item_by_name_in_collection(item_applied, cart)
    if cart_item && cart_item[:count] >= coupons[coupon_index][:num]
      if item_with_coupon
        item_with_coupon[:count] += coupons[coupon_index][:num]
        cart_item[:count] -= coupons[coupon_index][:num]
      else item_with_coupon = {
        :item => item_applied,
        :price => coupons[coupon_index][:cost] / coupons[coupon_index][:num],
        :count => coupons[coupon_index][:num],
        :clearance => cart_item[:clearance]
      }
      cart << item_with_coupon
      cart_item[:count] -= coupons[coupon_index][:num]
     end
    end
  coupon_index += 1
  end
  cart
end


def apply_clearance(cart)
 counter = 0
 while counter < cart.length do
   if cart[counter][:clearance]
     cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.2)).round(2)
   end
  counter += 1
 end
 cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart)
  final_cart = apply_clearance(coupon_cart)
  total = 0
  counter = 0
  while counter < final_cart.length do
    total += final_cart[counter][:price] * final_cart[counter][:count]
    counter += 1
  end
  if total > 100
    total -= (total - 0.10)
  end
  total
end

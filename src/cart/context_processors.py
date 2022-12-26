import json
from cart.models import *

def cookie_cart(request):

	#Create empty cart for now for non-logged in user
	try:
		cart = json.loads(request.COOKIES['cart'])
	except:
		cart = {}

	items = []
	order = {'get_cart_total':0, 'get_cart_items':0, 'shipping':False}
	cart_items = order['get_cart_items']
	cart_items_price = 0

	for i in cart:
		#We use try block to prevent items in cart that may have been removed from causing error
		try:	
			if(cart[i]['quantity']>0): #items with negative quantity = lot of freebies  
				cart_items += cart[i]['quantity']
				product = Product.objects.get(id=i)
				total = (product.price * cart[i]['quantity'])

				order['get_cart_total'] += total
				order['get_cart_items'] += cart[i]['quantity']		

				item = {
				'get_total': product.price * cart[i]['quantity'],
				'product': {
					'id': product.id, # type: ignore
					'product_name': product.product_name,
					'brief_info': product.brief_info,
					'price': product.price,
					'main_image': product.main_image
				}, 
				'quantity': cart[i]['quantity'],  # type: ignore
				'color': cart[i]['color'], # type: ignore
				}
				items.append(item)

				if product.digital == False:  # type: ignore
					order['shipping'] = True
		except:
			pass
			
	return {'cart_items': cart_items ,'order': order, 'items': items, 'get_cart_total': order['get_cart_total']}


def cart_data(request):
	if request.user.is_authenticated:
		user = request.user
		cart, created = Cart.objects.get_or_create(user=user, complete=False) 
		items = cart.cart_items.all() # type: ignore
		cart_items = cart.get_cart_items 
		cart_total = cart.get_cart_total
	else:
		cookie_data = cookie_cart(request)
		cart_items = cookie_data['cart_items'] # count of products 
		cart = cookie_data['order'] # {'get_cart_total': 5440.0, 'get_cart_items': 11, 'shipping': False}
		items = cookie_data['items'] 
		cart_total = cookie_data['get_cart_total']

	return {'cart_items': cart_items, 'cart_total': cart_total,'cart': cart, 'items': items } # type: ignore
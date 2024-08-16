import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()


clicked = False
st.title("Available Local Fresh Stores")
st.write('')
st.write('')
st.write('### Select a store to view its products')
products_data = {}

# Creates an order and adds the first product
def create_order(store_id, prod_id, quantity):
   order_data = {}
   order_data['customer_id'] = st.session_state['customer_id']
   order_data['store_id'] = store_id
   order_data['product_id'] = prod_id
   order_data['quantity'] = quantity
   st.session_state['has_order'] = True
   st.session_state['current_order_id'] = requests.post("http://api:4000/cl/customer/orders", json=order_data)

def show_products(store_id, store_name):
    clicked = True # TODO use this var for another func to "close" avail products on second click
    
    st.write('Products Available at {0}'.format(store_name))
    st.write('')
    st.write('')
    # TODO st.write('### Select a product to order(?)')
    try:
        # Showing each product
        products_data = requests.get('http://api:4000/s/stores/{0}/products'.format(store_id)).json()
        for product in products_data:
          #st.dataframe(product)
        #  st.write(product['units_in_stock'] + 4)
          '''
          if st.button(product['p_name'] + " , $" + product['price'] , use_container_width=True): 
            
            st.write("button works")
          '''
          # Setting up Order Form (order POST)
          with st.form("Order Form"):
              st.write(product['p_name'] + ' , $' + product['price'])
          #st.write(product['name'] + "  $" + ", " + product['units_in_stock'] + " left")
              amount_ordered = st.number_input("Select Amount to Order:", min_value=0, max_value=product['units_in_stock'], \
              step=1)
              submitted = st.form_submit_button("Submit")

              '''
              if submitted:
                if not st.session_state['has_order'] :
                  # create order + add to order
                  create_order(store_id, product['id'], product['quantity'])
                else:
                  # add to existing order
                    
                  order_data = {}
                  order_data['product_id'] = product['id']
                  order_data['order_id'] = st.session_state['current_order_id']
                  order_data['quantity'] = amount_ordered
                  requests.post("http://api:4000/cl/customer/orders/addToOrder".format(), json=order_data)
              '''
                  

    except:
        st.write("No products available for this store.")
        products_data = {"a":{"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}
    

    

data = {}
try:
  data = requests.get('http://api:4000/s/stores').json()
except:
  st.write("**Important**: Could not retrieve data for stores.")
  data = {"a":{"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}

for one_store in data:
    current_store_name = one_store["name"]
    current_store_id = one_store["id"]
    if st.button("{0}".format(one_store["name"]) ):#, on_click=show_products(one_store["id"], one_store["name"]))
       # current_store_name = one_store["name"] # maybe won't work, if need access to clicked button's name
        #requests.put('http://api:4000/cl/customer/current_store/{0}/{1}'.format(store["id"], st.session_state['customer_id']))
        #st.switch_page('pages/43_View_Store_Products.py')
       # show_products(one_store["id"])
        show_products(current_store_id, current_store_name)
        


    
 
    





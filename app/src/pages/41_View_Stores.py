import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()
# TODO: MAKE PLACING AN ORDER UPDATE UNITS_IN_STOCK FOR PRODUCTS 

#REFERENCE: https://discuss.streamlit.io/t/submit-form-button-not-working/35059/2
# (didn't end up using that one i think)

clicked = False

st.title("Available Local Fresh Stores")
st.write('')
st.write('')
st.write('### Select a store to view its products')
if st.button("Click to Finalize Order"):
   st.session_state['has_order'] = False


# Creates an order and adds the first product
def create_order(store_id, prod_id, quantity):
    if st.session_state['has_order'] == False:
      
      order_data = {}
      order_data['customer_id'] = st.session_state['customer_id']
      order_data['store_id'] = store_id
      order_data['product_id'] = prod_id
      order_data['quantity'] = quantity
      st.session_state['has_order'] = True
      #st.write(order_data)
      
      try:
        response = requests.post("http://api:4000/cl/customer/orders", json=order_data).json()
        
       # create_order(store_id, prod_id, quantity)
      except:
         st.write("failed to create order")
      st.session_state['current_order_id'] = response[0]['order_id']
      st.write("Order Created!")
  
    elif st.session_state['has_order'] == True:
    # add to existing order
      order_data = {}
      order_data['product_id'] = prod_id
      order_data['order_id'] = st.session_state['current_order_id']
      order_data['quantity'] = quantity
      #st.write(order_data)
      try:
        response = requests.post("http://api:4000/cl/customer/orders/addToOrder".format(), json=order_data).json()
        st.session_state['current_order_id'] = response[0]['order_id']
       # create_order(store_id, prod_id, quantity)
      except:
         st.write("failed to create order")
     # st.session_state['current_order_id'] = response[0]['order_id']
      st.write("Added to Current Order!")

def show_products(store_id, store_name):
    clicked = True # TODO use this var for another func to "close" avail products on second click
   
    st.write('Products Available at {0}'.format(store_name))
    st.write('')
    st.write('')
    # TODO st.write('### Select a product to order(?)')
    products_data = {}
    try:
        # Showing each product
        products_data = requests.get('http://api:4000/s/stores/{0}/products'.format(store_id)).json()
        
    except:
        st.write("No products available for this store.")
        products_data = {"a":{"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}
    #n = st.session_state['order_button_id']

    for product in products_data:
      with st.form(key="order_product{0}".format(product['id'])):
   #   n = n + 1
          # Setting up Order Form (order POST)  
        st.write(product['p_name'] + ' , $' + product['price'])
        amount_ordered = st.number_input("Select Amount to Order:", min_value=0, max_value=product['units_in_stock'], 
        step=1)
        submitted = st.form_submit_button(label="Add to Order")
        if submitted:
           create_order(store_id, product['id'], amount_ordered)


data = {}
try:
  data = requests.get('http://api:4000/s/stores').json()
except:
  st.write("**Important**: Could not retrieve data for stores.")
  data = {"a":{"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}

for one_store in data:
    with st.expander(one_store["name"]):
      show_products(one_store["id"], one_store["name"])
  
        


    
 
    





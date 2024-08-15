import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()


clicked = False
#current_store_name = ''
st.title("Available Local Fresh Stores")
st.write('')
st.write('')
st.write('### Select a store to view its products')
products_data = {}
def show_products(store_id, store_name):
    clicked = True # TODO use this var for another func to "close" avail products on second click
    
    st.write('Products Available at {0}'.format(store_name))
    st.write('')
    st.write('')
    # TODO st.write('### Select a product to order(?)')
    try:
        products_data = requests.get('http://api:4000/s/stores/{0}/products'.format(store_id)).json()
        st.dataframe(products_data)
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
        


    
 
    





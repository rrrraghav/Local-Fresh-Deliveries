import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

# Retrieve data for store that customer is viewing
customer_data = {}
try:
  customer_data = requests.get('http://api:4000/cl/customer/{0}'.format(st.session_state['customer_id'])).json()
except:
  st.write("**Important**: Could not retrieve data for customers.")
  customer_data = {"a":{"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}

if st.button('Click to show products'):
    store_data = {}
    try:
        store_data = requests.get('http://api:4000/s/stores/{0}'.format(customer_data['current_store'])).json()
    except:
        st.write("**Important**: Could not retrieve data for stores.")
        store_data = {"a":{"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}

    st.title('Products Available at {0}'.format(store_data['name']))
    st.write('')
    st.write('')
    # TODO st.write('### Select a product to order(?)')
    try:
        products_data = requests.get('https://api:4000/s/stores/{0}/products'.format(store_data['id']))
    except:
        st.write("**Important**: Could not retrieve data for products.")
        store_data = {"a":{"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}
    
    st.dataframe(products_data)

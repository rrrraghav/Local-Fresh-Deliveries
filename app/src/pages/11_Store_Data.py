import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()

st.title('Local Stores Order Data')
st.write('')
st.write('')
st.write('### Select a store to view its order data')
clicked = False
order_data = {}
seen_store_names = set()

def show_orders(store_id, store_name):
    global clicked
    clicked = not clicked 
    
    if clicked:
        st.write(f'Orders at {store_name}')
        st.write('')
        st.write('')
        try:
            order_data = requests.get(f'http://api:4000/a/analyst/1/stores/{store_id}/orders').json()
            st.dataframe(order_data)
        except:
            st.write("No orders available for this store.")
            order_data = {"a": {"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}
    else:
        st.write('')

data = {}
try:
    data = requests.get('http://api:4000/a/analyst/1/stores').json()
except:
    st.write("**Important**: Could not retrieve data for stores.")
    data = {"a": {"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}

for idx, one_store in enumerate(data):
    current_store_name = one_store["name"]
    current_store_id = one_store["id"]
    if current_store_name not in seen_store_names:
        seen_store_names.add(current_store_name)
        if st.button(f"{current_store_name}", key=f"store_button_{current_store_id}"):
            show_orders(current_store_id, current_store_name)
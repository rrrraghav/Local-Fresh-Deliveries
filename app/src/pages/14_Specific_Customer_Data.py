import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.title("Customer Information")
st.write('')
st.write('')
st.write('### Select a customer to view their order data')

clicked = False
order_data = {}
seen_customer_names = set()  

def show_customer_orders(customer_id, customer_name):
    global clicked
    clicked = not clicked  
    
    if clicked:
        st.write(f'Orders for {customer_name}')
        st.write('')
        st.write('')
        try:
            order_data = requests.get(f'http://api:4000/a/analyst/1/customers/{customer_id}/orders').json()
            st.dataframe(order_data)
        except:
            st.write("No orders available for this customer.")
            order_data = {"a": {"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}
    else:
        st.write('')

data = {}
try:
    data = requests.get('http://api:4000/a/analyst/1/customers').json()
except:
    st.write("**Important**: Could not retrieve data for customers.")
    data = {"a": {"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}

for idx, one_customer in enumerate(data):
    current_customer_name = f"{one_customer['first_name']} {one_customer['last_name']}"
    current_customer_id = one_customer["id"]
    
    if current_customer_name not in seen_customer_names:
        seen_customer_names.add(current_customer_name)
        if st.button(f"{current_customer_name}", key=f"customer_button_{current_customer_id}"):
            show_customer_orders(current_customer_id, current_customer_name)

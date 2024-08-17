import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks
import pandas as pd

SideBarLinks()

st.title("Local Fresh Customer Data")
st.write('')
st.write('### Retrieve and Analyze Customer Data')

def get_customer_data():
    response = requests.get('http://api:4000/a/analyst/1/customers')
    return pd.DataFrame(response.json())


def get_customer_orders(customer_id):
    response = requests.get(f'http://api:4000/a/analyst/1/customers/{customer_id}/orders')
    return pd.DataFrame(response.json())

customer_data = get_customer_data()

if not customer_data.empty:
    st.write("### Customer Data")
    st.dataframe(customer_data)

    st.write("### Filter Options")

    id_filter = st.text_input("Filter by ID")
    if id_filter:
        customer_data = customer_data[customer_data['id'].astype(str).str.contains(id_filter, case=False)]
    
    first_name_filter = st.text_input("Filter by First Name")
    if first_name_filter:
        customer_data = customer_data[customer_data['first_name'].str.contains(first_name_filter, case=False)]
    
    last_name_filter = st.text_input("Filter by Last Name")
    if last_name_filter:
        customer_data = customer_data[customer_data['last_name'].str.contains(last_name_filter, case=False)]
    
    email_filter = st.text_input("Filter by Email")
    if email_filter:
        customer_data = customer_data[customer_data['email'].str.contains(email_filter, case=False)]
    
    phone_filter = st.text_input("Filter by Phone Number")
    if phone_filter:
        customer_data = customer_data[customer_data['phone'].str.contains(phone_filter, case=False)]
    
    if not customer_data.empty:
        st.write("### Filtered Customer Data")
        st.dataframe(customer_data)
        
        selected_customer_id = st.selectbox("Select a customer ID to view their orders", customer_data['id'])
        
        if st.button("Get Order Data"):
            order_data = get_customer_orders(selected_customer_id)
            if not order_data.empty:
                st.write(f"### Order Data for Customer ID: {selected_customer_id}")
                st.dataframe(order_data)
            else:
                st.write("No order data available for this customer.")
    else:
        st.write("No customer data matches the filters.")
else:
    st.write("No customer data available.")



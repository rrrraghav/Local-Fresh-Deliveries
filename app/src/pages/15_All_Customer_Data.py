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

# Fetch customer data
def get_customer_data():
    try:
        response = requests.get('http://api:4000/a/analyst/1/customers')
        if response.status_code == 200:
            return pd.DataFrame(response.json())
        else:
            st.error("Failed to retrieve customer data.")
            return pd.DataFrame()
    except Exception as e:
        st.error(f"Error fetching data: {str(e)}")
        return pd.DataFrame()

customer_data = get_customer_data()

if not customer_data.empty:
    st.write("### Customer Data")
    st.dataframe(customer_data)

    st.write("### Filter Options")

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
    else:
        st.write("No customer data matches the filters.")
else:
    st.write("No customer data available.")



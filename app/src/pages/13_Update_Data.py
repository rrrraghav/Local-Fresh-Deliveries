import logging
logger = logging.getLogger(__name__)
import streamlit as st
import pandas as pd
from sklearn import datasets
from sklearn.ensemble import RandomForestClassifier
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks
import requests

SideBarLinks()

st.title("Update Driver and Store Information")
st.write('')
st.write('### Update Driver Information')

driver_id = st.text_input("Enter Driver ID:")
first_name = st.text_input("Enter Driver's First Name:")
last_name = st.text_input("Enter Driver's Last Name:")
vehicle_type = st.text_input("Enter Vehicle Type:")

if st.button("Update Driver"):
    if driver_id and first_name and last_name and vehicle_type:
        update_data = {
            "first_name": first_name,
            "last_name": last_name,
            "vehicle_type": vehicle_type
        }
        try:
            response = requests.put(f'http://api:4000/a/analyst/1/drivers/{driver_id}', json=update_data)
            if response.status_code == 200:
                st.success("Driver information updated successfully!")
            else:
                st.error("Failed to update driver information.")
        except Exception as e:
            st.error(f"Error: {str(e)}")
    else:
        st.warning("Please fill out all driver fields.")

st.write('---')
st.write('### Update Store Information')

store_id = st.text_input("Enter Store ID:")
store_name = st.text_input("Enter Store Name:")
store_phone = st.text_input("Enter Store Phone:")

if st.button("Update Store"):
    if store_id and store_name and store_phone:
        update_data = {
            "name": store_name,
            "phone": store_phone
        }
        try:
            response = requests.put(f'http://api:4000/a/analyst/1/store/{store_id}', json=update_data)
            if response.status_code == 200:
                st.success("Store information updated successfully!")
            else:
                st.error("Failed to update store information.")
        except Exception as e:
            st.error(f"Error: {str(e)}")
    else:
        st.warning("Please fill out all store fields.")
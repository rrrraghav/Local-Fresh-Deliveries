import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"{st.session_state['first_name']}, view an order's cost.")

driver_id = st.session_state['driver_id']
order_id = st.session_state['order_id']

url = f'http://api:4000/d/drivers/{driver_id}/orders/{order_id}'

try:
    order = requests.get(url).json()
    st.dataframe(order)
except:
    st.error("Failed to retrieve orders")

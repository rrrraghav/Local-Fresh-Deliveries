import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"{st.session_state['first_name']}, update your profile.")
st.write("")
st.write("")

driver_id = st.session_state['driver_id']

url = f'http://api:4000/d/drivers/{driver_id}'

try:
    order = requests.get(url).json()
    st.write("Your information:")
    st.dataframe(order)
except:
    st.error("Failed to retrieve orders")

st.write("")
st.write("")

st.write("## Update your information:")
with st.form("Update info"):
    fn = st.text_input("First name")
    ln = st.text_input("Last name")
    vt = st.text_input("Vehicle type")

    submit = st.form_submit_button("Submit")

    if submit:
        data = {}
        data['first_name'] = fn
        data['last_name'] = ln
        data['vehicle_type'] = vt
        requests.put(url, json=data)

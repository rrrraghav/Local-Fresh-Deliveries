import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"{st.session_state['first_name']}, log a completed delivery")
st.write('')
st.write('')

driver_id = st.session_state['driver_id']
order_id = st.session_state['order_id']

url = f'http://api:4000/d/drivers/{driver_id}/orders/{order_id}'

st.write('## Insert the time at which your delivery was completed:')
with st.form('Time fulfilled'):
    tf = st.time_input("Time at delivery")

    submit = st.form_submit_button("Submit")

    if submit:
        data = {
            "time_fulfilled": tf.strftime('%H:%M:%S')
        }
        response = requests.put(url, json=data)
        if response.status_code == 200:
            st.success("Order successfully updated")
        else:
            st.error("Failed to update order")

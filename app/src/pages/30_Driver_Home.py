import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome {st.session_state['first_name']}.")
st.write('')
st.write('')

st.write("### What would you like to do today?")
st.write('')
st.write('')

if st.button('View Past Orders', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/31_View_Orders.py')

if st.button('Update Delivery Information', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/32_Completed_Delivery.py')

if st.button('View Order Cost', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/33_View_Order_Cost.py')

if st.button('Your Profile', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/34_Driver_Profile.py')

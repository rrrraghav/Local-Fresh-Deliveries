import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Driver, {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('Update your personal information', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/31_Update_Info.py')

if st.button('View your past deliveries', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/32_View_Orders.py')

if st.button('Log a completed delivery', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/33_Completed_Delivery.py')

if st.button('View the cost of a specific order', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/34_View_Order_Cost.py')

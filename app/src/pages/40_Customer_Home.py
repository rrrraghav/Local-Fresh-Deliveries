import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome {st.session_state['first_name']}, hungry?")
st.write('')
st.write('')
st.write('### Choose an action below:')

if st.button('View Stores', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/41_View_Stores.py')

if st.button('Your Profile', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/42_Customer_Profile.py')


if st.button('View Orders', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/43_View_Orders.py')

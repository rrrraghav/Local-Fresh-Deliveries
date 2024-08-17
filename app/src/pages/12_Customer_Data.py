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
st.write('### Choose an action below:')

if st.button('Specific Customer Data', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/14_Specific_Customer_Data.py')

if st.button('All Customer Data', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/15_All_Customer_Data.py')



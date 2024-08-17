import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()

st.title('Welcome Store Owner, Max')

if st.button('View Your Current Products', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/21_View_Store_Prdts.py')

if st.button('Add a New Product', 
             type='primary',
             use_container_width=True):
  st.switch_page('pages/21_ML_Model_Mgmt.py')
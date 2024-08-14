import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.title("Available Local Fresh Stores")
st.write('')
st.write('')
st.write('### Select a store to view its products')

data = {}
try:
  data = requests.get('http://api:4000/s/stores').json()
except:
  st.write("**Important**: Could not retrieve data for stores.")
  data = {"a":{"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}

for store in data:
    st.button("{0}".format(store["name"]))
 
    





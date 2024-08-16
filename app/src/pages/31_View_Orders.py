import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests
import urllib.parse

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"View your orders, {st.session_state['first_name']}.")

url = st.query_params('url')
parsed_url = urllib.parse.urlparse(url)
id = parsed_url.path.split('/')[-1]

response = requests.get(f'http://api:4000/d/driver/{id}/orders').json()
st.dataframe(response)

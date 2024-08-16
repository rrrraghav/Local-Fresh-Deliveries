import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests
import urllib.parse

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Driver, {st.session_state['first_name']}.")
st.write('')
st.write('')

st.write("Here's your information:")
st.write('')
st.write('')

st.write('Update your personal information:')
with st.form("Update your personal information:"):
  fn = st.text_input("First Name")
  ln = st.text_input("Last Name")
  vt = st.text_input("Vehicle Type")
  submit_button = st.form_submit_button('Submit')
  if submit_button:
    logger.log('Driver info updated')
    data = {}
    url = st.experimental_get_query_params()["url"]
    parsed_url = urllib.parse.urlparse(url)
    id = parsed_url.path.split('/')[-1]
    data['id'] = id
    data['first_name'] = fn
    data['last_name'] = ln
    data['vehicle_type'] = vt
    response = requests.post(f'http://api:4000/d/driver/{id}', json=data)

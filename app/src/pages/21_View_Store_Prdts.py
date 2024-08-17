import logging
logger = logging.getLogger(__name__)
import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()

st.title('Welcome Store Owner, Max')

st.write('\n\n')
st.write('## Here is a list of your currently listed products:')
st.write('### Select a product to view or edit its details')

data = {}
try:
  data = requests.get('http://api:4000/s/stores/1/products').json()
except:
  st.write("**Important**: Could not retrieve data for stores.")
  data = {"a":{"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}



for product in data:
    current_product_name = product['name']
    current_product_id = product['id']

    if st.button("{0}".format(product["name"]) ):
       product_detail = {}
       product_detail = requests.get('http://api:4000/s/stores/1/products/{0}'.format(current_product_id)).json()
       st.dataframe(product_detail)


st.write('Update product below:')
with st.form("Update your product information:"):
    product_id = st.text_input("Product ID")
    price = st.text_input("Price")
    units = st.text_input("Units in Stock")
    submit_button = st.form_submit_button('Submit')

    if submit_button:
      logger.log(logging.INFO, 'Product Details Updated')
      updated_data = {
          "id": product_id,
          "price": price,
          "units_in_stock": units
      }
      if product_id:
        response = requests.put('http://api:4000/s/stores/1/products', json=updated_data)
      else:
         st.error("Product ID is required.")


       
            
            
          
        
          
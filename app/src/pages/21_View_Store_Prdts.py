import logging
logger = logging.getLogger(__name__)
import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()

st.title('Welcome Store Owner, Max')

st.write('\n')
st.write('## Here is a list of your current products:')
st.write('\n')


data = {}
try:
  data = requests.get('http://api:4000/s/stores/1/products').json()
except:
  st.write("**Important**: Could not retrieve data for products.")
  data = {"a":{"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}

product_ids = []
for product in data:
    product_ids.append(product['id'])

st.write('Select a product to view its details:')

for product in data:
    current_product_name = product['p_name']
    current_product_id = product['id']

    if st.button("{0}".format(product["p_name"]) ):
       product_detail = {}
       product_detail = requests.get('http://api:4000/s/stores/1/products/{0}'.format(current_product_id)).json()
       st.dataframe(product_detail)

st.write('Update product below:')

with st.form("Update your product information:"):
    product_id_str = st.text_input("Product to Update (Product ID)")
    price = st.text_input("Price")
    units = st.text_input("Units in Stock")
    submit_button = st.form_submit_button('Submit')

    if product_id_str:
      product_id = int(product_id_str)
    else:
       product_id = product_id_str

    if submit_button:
      logger.log(logging.INFO, 'Product Details Updated')
      updated_data = {
          "id": product_id,
          "price": price,
          "units_in_stock": units
      }

      if not product_id:
        st.error("Product ID is required.")
      elif product_id not in product_ids:
        st.error("Product ID does not exist for your store.")
      elif not price or not units:
        st.error("Cannot leave any values blank.")
      else:
        response = requests.put('http://api:4000/s/stores/1/products', json=updated_data)
        if response.status_code == 200:
          st.success("Product Successfully Updated")
        else:
          st.error(f"Failed to update product: {response.text}")




       
            
            
          
        
          
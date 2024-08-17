import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()

st.title('Welcome Store Owner, Max')

st.write('Add a new product below:')

categories = {'Healthy':1, 'Convenient':2, 'Seafood':3, 'Poultry': 4,
              'Vegetables':5, 'Fruit':6, 'Farm Fresh':7, 'Bakery':8}
category_names = list(categories.keys())


with st.form("Enter your new products information:"):
    name = st.text_input("Product Name")
    units = st.text_input("Units in Stock")
    price = st.text_input("Price")
    category_name = st.selectbox("Category", category_names)

    submit_button = st.form_submit_button('Add Product')
    
    if submit_button:
      logger.log(logging.INFO, 'Product Details Updated')
      category = categories[category_name]
      new_product_data = {
          "name": name,
          "units_in_stock": units,
          "price": price,
          "category_id": category
      }
      
      if name and price and units and category:
        response = requests.post('http://api:4000/s/stores/1/products', json=new_product_data)
        if response.status_code == 200:
          st.success("Product was successfully added")

      else:
        st.error("Cannot leave any values blank")
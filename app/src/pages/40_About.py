import streamlit as st
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# About this App")

st.markdown (
    """
    This is an app representing a local food delivery service called Local Fresh Deliveries. 

    This project was born from the realization that, while there are many grocery delivery services, there are few that cater towards those that desire food delivered directly from local farms and fish markets. Intended users consist of restaurants and private chefs in need of last minute groceries that cannot be bought with quality standards in mind from commercial grocery stores such as Walmart or Vons. The app connects local farms and fish markets with delivery drivers, who pick up local produce and deliver it to customers. For a customer, they can view what produce is available at which stores, and can order what they want. A driver will then pick up their order and deliver it to their doorstep. 
    """
        )

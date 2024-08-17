# Idea borrowed from https://github.com/fsmosca/sample-streamlit-authenticator

import streamlit as st

#### ------------------------ General ------------------------
def HomeNav():
    st.sidebar.page_link("Home.py", label="Home", icon='🏠')

def AboutPageNav():
    st.sidebar.page_link("pages/40_About.py", label="About", icon="🧠")

#### ------------------------ Examples for Role of customer ------------------------
def PolStratAdvHomeNav():
    st.sidebar.page_link("pages/00_Pol_Strat_Home.py", label="Political Strategist Home", icon='👤')

def WorldBankVizNav():
    st.sidebar.page_link("pages/01_World_Bank_Viz.py", label="World Bank Visualization", icon='🏦')

def MapDemoNav():
    st.sidebar.page_link("pages/02_Map_Demo.py", label="Map Demonstration", icon='🗺️')

'''
LOCAL FRESH PAGES:
'''
def CustomerHomeNav():
    st.sidebar.page_link("pages/40_Customer_Home.py", label="Home", icon='😛')
def CustomerCreateOrderNav():
    st.sidebar.page_link("pages/41_View_Stores.py", label="Stores", icon='🏪')

def CustomerViewOrdersNav():
    st.sidebar.page_link("pages/43_View_Orders.py", label="Orders", icon='📜')

## ------------------------ Examples for Role of usaid_worker ------------------------
def StoreData():
    st.sidebar.page_link("pages/11_Store_Data.py", label="Store Data", icon='🏢')

def CustData():
    st.sidebar.page_link("pages/12_Customer_Data.py", label="Customer Data", icon='📈')

def UpdateData():
    st.sidebar.page_link("pages/13_Update_Data.py", label="Update Data", icon='🖥️')

#### ------------------------ Store Role ------------------------
def StoreHomeNav():
    st.sidebar.page_link("pages/20_Store_Home.py", label="Store Owner Home", icon='🖥️')

def ViewProdsNav():
    st.sidebar.page_link("pages/21_View_Store_Prdts.py", label='View/Update Products', icon='🖥️')
            
def AddProdNav():
    st.sidebar.page_link("pages/22_Add_Product.py", label='Add Products', icon='🖥️')

#### ------------------------ Driver Role ------------------------
def DriverHomeNav():
    st.sidebar.page_link("pages/30_Driver_Home.py", label="Driver Home", icon='🖥️')

def ViewOrdersNav():
    st.sidebar.page_link("pages/31_View_Orders.py", label="View past deliveries", icon='🖥️')

def CompletedDeliveryNav():
    st.sidebar.page_link("pages/32_Completed_Delivery.py", label="Log a completed delivery", icon='🖥️')

def ViewOrderCostNav():
    st.sidebar.page_link("pages/33_View_Order_Cost.py", label="View an order's cost", icon='🖥️')

def DriverProfileNav():
    st.sidebar.page_link("pages/34_Driver_Profile.py", label="View your profile", icon='🖥️')

# --------------------------------Links Function -----------------------------------------------
def SideBarLinks(show_home=True):
    """
    This function handles adding links to the sidebar of the app based upon the logged-in user's role, which was put in the streamlit session_state object when logging in. 
    """    

    # add a logo to the sidebar always
    st.sidebar.image("assets/logo.jpeg", width = 300)

    # If there is no logged in user, redirect to the Home (Landing) page
    if 'authenticated' not in st.session_state:
        st.session_state.authenticated = False
        st.switch_page('Home.py')
        
    if show_home:
        # Show the Home page link (the landing page)
        HomeNav()

    # Show the other page navigators depending on the users' role.
    if st.session_state["authenticated"]:

        # Show World Bank Link and Map Demo Link if the user is a political strategy advisor role.
        if st.session_state['role'] == 'pol_strat_advisor':
            PolStratAdvHomeNav()
            WorldBankVizNav()
            MapDemoNav()

        # If the user role is usaid worker, show the Api Testing page
        if st.session_state['role'] == 'analyst':
            StoreData()
            CustData()
            UpdateData()
        
        # If the user is an administrator, give them access to the administrator pages
        if st.session_state['role'] == 'administrator':
            AdminPageNav()

        # If the user is a driver, give them access to the driver pages
        if st.session_state['role'] == 'driver':
            DriverHomeNav()
            ViewOrdersNav()
            CompletedDeliveryNav()
            ViewOrderCostNav()
            DriverProfileNav()

        if st.session_state['role'] == 'customer':
            CustomerHomeNav()
            CustomerCreateOrderNav()
            CustomerViewOrdersNav()

        # If the user is a store owners, give them access to the driver pages
        if st.session_state['role'] == 'store':
            StoreHomeNav()
            ViewProdsNav()
            AddProdNav()

    # Always show the About page at the bottom of the list of links
    AboutPageNav()

    if st.session_state["authenticated"]:
        # Always show a logout button if there is a logged in user
        if st.sidebar.button("Logout"):
            del st.session_state['role']
            del st.session_state['authenticated']
            st.switch_page('Home.py')


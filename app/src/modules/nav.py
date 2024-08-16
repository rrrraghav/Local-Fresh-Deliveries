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
    st.sidebar.page_link("pages/40_Customer_Home.py", label="Customer Home", icon='😛')
def CustomerCreateOrderNav():
    st.sidebar.page_link("pages/41_Customer_View_Stores.py", label="View Available Stores", icon='🏪')


# TODO: Store & Driver Homepages 

## ------------------------ Examples for Role of usaid_worker ------------------------
def ApiTestNav():
    st.sidebar.page_link("pages/12_API_Test.py", label="Test the API", icon='🛜')

def PredictionNav():
    st.sidebar.page_link("pages/11_Prediction.py", label="Regression Prediction", icon='📈')

def ClassificationNav():
    st.sidebar.page_link("pages/13_Classification.py", label="Classification Demo", icon='🌺')

#### ------------------------ Store Role ------------------------
def AdminPageNav():
    st.sidebar.page_link("pages/20_Admin_Home.py", label="System Admin", icon='🖥️')
    st.sidebar.page_link("pages/21_ML_Model_Mgmt.py", label='ML Model Management', icon='🏢')

#### ------------------------ Driver Role ------------------------
def DriverHomeNav():
    st.sidebar.page_link("pages/30_Driver_Home.py", label="Driver Home", icon='🖥️')

def ViewOrdersNav():
    st.sidebar.page_link("pages/31_View_Orders.py", label="View past deliveries", icon='🖥️')

def CompletedDeliveryNav():
    st.sidebar.page_link("pages/32_Completed_Delivery.py", label="Log a completed delivery", icon='🖥️')

def ViewOrderCostNav():
    st.sidebar.page_link("pages/33_View_Order_Cost.py", label="View an order's cost", icon='🖥️')

# --------------------------------Links Function -----------------------------------------------
def SideBarLinks(show_home=True):
    """
    This function handles adding links to the sidebar of the app based upon the logged-in user's role, which was put in the streamlit session_state object when logging in. 
    """    

    # add a logo to the sidebar always
    st.sidebar.image("assets/logo.png", width = 150)

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
        if st.session_state['role'] == 'usaid_worker':
            PredictionNav()
            ApiTestNav() 
            ClassificationNav()
        
        # If the user is an administrator, give them access to the administrator pages
        if st.session_state['role'] == 'administrator':
            AdminPageNav()

        # If the user is a driver, give them access to the driver pages
        if st.session_state['role'] == 'driver':
            DriverHomeNav()
            ViewOrdersNav()
            CompletedDeliveryNav()
            ViewOrderCostNav()

        if st.session_state['role'] == 'customer':
            CustomerHomeNav()

    # Always show the About page at the bottom of the list of links
    AboutPageNav()

    if st.session_state["authenticated"]:
        # Always show a logout button if there is a logged in user
        if st.sidebar.button("Logout"):
            del st.session_state['role']
            del st.session_state['authenticated']
            st.switch_page('Home.py')


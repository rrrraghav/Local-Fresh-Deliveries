##################################################
# This is the main/entry-point file for the 
# sample application for your project
##################################################



# Set up basic logging infrastructure
import logging
logging.basicConfig(format='%(filename)s:%(lineno)s:%(levelname)s -- %(message)s', level=logging.INFO)
logger = logging.getLogger(__name__)



# import the main streamlit library as well
# as SideBarLinks function from src/modules folder
import streamlit as st
from modules.nav import SideBarLinks

# streamlit supports reguarl and wide layout (how the controls
# are organized/displayed on the screen).
st.set_page_config(layout = 'wide')

# If a user is at this page, we assume they are not 
# authenticated.  So we change the 'authenticated' value
# in the streamlit session_state to false. 
st.session_state['authenticated'] = False

# Use the SideBarLinks function from src/modules/nav.py to control
# the links displayed on the left-side panel. 
# IMPORTANT: ensure src/.streamlit/config.toml sets
# showSidebarNavigation = false in the [client] section
SideBarLinks(show_home=True)

# ***************************************************
#    The major content of this page
# ***************************************************

# set the title of the page and provide a simple prompt. 
logger.info("Loading the Home page of the app")
st.title('Local Fresh Deliveries')
st.write('\n\n')
st.write('### HI! As which user would you like to log in?')

# For each of the user personas for which we are implementing
# functionality, we put a button on the screen that the user 
# can click to MIMIC logging in as that mock user. 

if st.button("Act as Steve, a Customer", 
            type = 'primary', 
            use_container_width=True):
    # when user clicks the button, they are now considered authenticated
    st.session_state['authenticated'] = True
    # we set the role of the current user
    st.session_state['role'] = 'customer'
    # we add the first name of the user (so it can be displayed on 
    # subsequent pages). 
    st.session_state['first_name'] = 'Steve'
    # finally, we ask streamlit to switch to another page, in this case, the 
    # landing page for this particular user type
    logger.info("Logging in as Customer")
    st.switch_page('pages/00_Customer_Home.py')

if st.button('Act as Josh, a Data Analyst', 
            type = 'primary', 
            use_container_width=True):
    st.session_state['authenticated'] = True
    st.session_state['role'] = 'analyst'
    st.session_state['first_name'] = 'Josh'
    logger.info('Logging in as analyst')
    st.switch_page('pages/10_Analyst_Home.py')

if st.button('Act as Max, a Fisherman', 
            type = 'primary', 
            use_container_width=True):
    st.session_state['authenticated'] = True
    st.session_state['role'] = 'store'
    st.session_state['first_name'] = 'Max'
    logger.info('Logging in as store')
    st.switch_page('pages/20_Store_Home.py')

if st.button('Act as Sally, a Delivery Driver', 
            type = 'primary', 
            use_container_width=True):
    st.session_state['authenticated'] = True
    st.session_state['role'] = 'driver'
    st.session_state['first_name'] = 'Sally'
    logger.info('Logging in as driver')
    st.switch_page('pages/30_Driver_Home.py')

if st.button('Act as Steve, a Local Fresh Customer', 
            type = 'primary', 
            use_container_width=True):
    st.session_state['authenticated'] = True
    st.session_state['role'] = 'customer'
    st.session_state['first_name'] = 'Steve'
    # SETTING SESSION STATE VARIABLE TO CORRESPOND TO SAMPLE STEVE PERSONA DATA
    st.session_state['customer_id'] = 333 #sample insert has id 333
    # can put post request here to make customer for Steve
    
    st.switch_page('pages/40_Customer_Home.py')


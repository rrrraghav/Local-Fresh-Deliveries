import logging
logging.basicConfig(level=logging.DEBUG)

from flask import Flask

from backend.db_connection import db
from backend.stores.store_routes import stores
from backend.customer.lfcustomer_routes import customer #local fresh customer
from backend.drivers.driver_routes import drivers
from backend.analyst.analyst_routes import analyst


import os
from dotenv import load_dotenv

def create_app():
    app = Flask(__name__)

    # Load environment variables
    load_dotenv()

    # secret key that will be used for securely signing the session 
    # cookie and can be used for any other security related needs by 
    # extensions or your application
    # app.config['SECRET_KEY'] = 'someCrazyS3cR3T!Key.!'
    app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')

    # # these are for the DB object to be able to connect to MySQL. 
    # app.config['MYSQL_DATABASE_USER'] = 'root'
    app.config['MYSQL_DATABASE_USER'] = os.getenv('DB_USER')
    app.config['MYSQL_DATABASE_PASSWORD'] = os.getenv('MYSQL_ROOT_PASSWORD')
    app.config['MYSQL_DATABASE_HOST'] = os.getenv('DB_HOST')
    app.config['MYSQL_DATABASE_PORT'] = int(os.getenv('DB_PORT'))
    app.config['MYSQL_DATABASE_DB'] = os.getenv('DB_NAME')  # Change this to your DB name

    # Initialize the database object with the settings above. 
    db.init_app(app)

    # Add the default route
    # Can be accessed from a web browser
    # http://ip_address:port/
    # Example: localhost:8001
    @app.route("/")
    def welcome():
        return "<h1>Welcome to the Summer 2024 CS 3200 Project Template Repo</h1>"
    
    # Example route for testing streamlit
    @app.route("/data")
    def getData():
        data = {
            "staff": [
                {
                    "Name": "Mark Fontenot",
                    "role": "Instructor"
                },
                {
                    "Name": "Ashley Davis",
                    "role": "TA"
                },
                {
                    "Name": "Dylan Toplas",
                    "role": "TA"
                },
                {
                    "Name": "Hazelyn Aroian",
                    "role": "TA"
                },
                {
                    "Name": "Jared Lyon",
                    "role": "TA"
                },
                {
                    "Name": "Khanh Nguyen",
                    "role": "TA"
                },
                {
                    "Name": "Nathan Cheung",
                    "role": "TA"
                },
                {
                    "Name": "Nicole Contreras",
                    "role": "TA"
                },
                {
                    "Name": "Reid Chandler",
                    "role": "TA"
                },
                {
                    "Name": "Sai Kumar Reddy",
                    "role": "TA"
                }
            ]
        }
        return data
    
    app.logger.info('current_app(): registering blueprints with Flask app object.')

    # LOCAL FRESH BLUEPRINTS:
    '''
    NOTE: 
    - the current blueprint is ***customer*** so that it doesn't overlap with sample data. 
    - I figured we'd want to keep the sample data there till we're ready to remove. 
    - Also take note that the url_prefix is currently /cl <-- that's a lowercase L
    - Folder for this persona is also called "customer" currently
    '''
    app.register_blueprint(customer, url_prefix='/cl') # Steve/customers
    app.register_blueprint(stores, url_prefix='/s')
    app.register_blueprint(drivers, url_prefix='/d')
    app.register_blueprint(analyst,     url_prefix='/a')

    # Don't forget to return the app object
    return app


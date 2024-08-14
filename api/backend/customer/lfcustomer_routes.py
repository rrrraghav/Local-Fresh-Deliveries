from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db
from backend.ml_models.model01 import predict

customer = Blueprint('customer', __name__)
'''
Routes file for handling "customer" entity endpoints("customers" in database)
Handles user stories for Steve and Josh 

'''
# Get all stores from the DB
# NOTE: made it /customer here as well for...consistency?
@customer.route('/customer', methods=['GET'])
def get_customers():
    
    current_app.logger.info('customer_routes.py: GET /customer')
    cursor = db.get_db().cursor()
    cursor.execute(
        'select id, first_name, last_name, \
        age, dob, address, email \
        from customers') #NOTE: table name is "customers"
    # row_headers = [x[0] for x in cursor.description]
    # json_data = []
    theData = cursor.fetchall()
    # for row in theData:
    #     json_data.append(dict(zip(row_headers, row)))
    # the_response = make_response(jsonify(json_data))
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
    

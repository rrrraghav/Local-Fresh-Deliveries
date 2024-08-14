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
    
# Get customer detail for customer with particular cust_id
# [Steve-1]
@customer.route('/customer/<cust_id>', methods=['GET'])
def get_lfcustomer(cust_id): #NOTE: function name, "get_lfcustomer".
    current_app.logger.info('GET /customer/<cust_id> route')
    cursor = db.get_db().cursor()
    cursor.execute('select id, first_name, last_name, \
    age, dob, address, email from customers where id = {0}'.format(cust_id))
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

#GET endpoint. [Steve 1.4, reading an order]
@customer.route('/customer/<cust_id>/orders/<order_id>', methods= ['GET'])
def get_lfcustomer_order(cust_id, order_id):
    current_app.logger.info('GET /customer/<cust_id>/orders/<order_id> route')
    cursor = db.get_db().cursor()
    cursor.execute('SELECT o.id, o.delivery_address, o.time_created, o.time_fulfilled, d.first_name \
    FROM orders o JOIN customers c ON o.customer_id = c.id \
    JOIN driver d ON o.driver_id = d.id  \
    WHERE c.id = {0} AND o.id = {1}'.format(cust_id, order_id))
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


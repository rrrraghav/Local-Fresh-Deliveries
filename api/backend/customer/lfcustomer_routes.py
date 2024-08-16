from flask import Blueprint, request, jsonify, make_response, current_app
import json
import logging
logger = logging.getLogger(__name__)
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
    cursor.execute('SELECT o.id AS order_id, o.delivery_address, o.time_created, o.time_fulfilled, s.name AS store_name \
    , d.first_name AS d_name \
    FROM orders o JOIN customers c ON o.customer_id = c.id \
    JOIN store s on o.store_id = s.id \
    JOIN driver d ON o.driver_id = d.id \
    WHERE c.id = {0} AND o.id = {1}  \
    '.format(cust_id, order_id))
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

#GET endpoint. [Steve 1.4, viewing products in an order]
@customer.route('/customer/orders/<order_id>/products', methods= ['GET'])
def get_all_lfcustomer_order_products(order_id):
    current_app.logger.info('GET /customer/orders/<order_id>/products route')
    cursor = db.get_db().cursor()

    cursor.execute('select p.name as prod_name, p.price, sum(quantity) as quantity from \
                   orders_product op join product p on op.product_id = p.id \
                   where op.orders_id = {0} group by p.id '.format(order_id))
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    
    return the_response

#GET endpoint. [Steve 1.4, viewing all products in an order]
@customer.route('/customer/<cust_id>/orders', methods= ['GET'])
def get_all_lfcustomer_order(cust_id):
    current_app.logger.info('GET /customer/<cust_id>/orders/ route')
    cursor = db.get_db().cursor()
    cursor.execute('SELECT o.id AS order_id, o.delivery_address, o.time_created, o.time_fulfilled, d.first_name AS d_name\
    FROM orders o JOIN customers c ON o.customer_id = c.id \
    JOIN driver d ON o.driver_id = d.id  \
    WHERE c.id = {0}'.format(cust_id))
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    
    return the_response

#POST endpoint. [Steve 1.4, creating an order]
@customer.route('/customer/orders', methods= ['POST'])
def post_lfcustomer_order():
    # collecting data from the request object 
    current_app.logger.info('attempting to create order...')
    the_data = request.json
    current_app.logger.info(the_data)
    cursor = db.get_db().cursor()

    #extracting the variable
    cust_id = the_data['customer_id']
    store_id = the_data['store_id']
    prod_id = the_data['product_id']
    quantity = the_data['quantity']

    
    # NOTE: fetches first address by id; i.e., treats that address as primary store address
    cursor.execute('select address from store_addresses where id = {0} limit 1'.format(store_id)) 
    pickup_address = cursor.fetchall()
    cursor.execute('select address from customers where id = {0}'.format(cust_id))
    delivery_address = cursor.fetchall()
    cursor.execute('insert into orders (pickup_address, delivery_address, customer_id, store_id) \
                   values ({0}, {1}, {2}, {3})\
                   returning id'.format(pickup_address, delivery_address, cust_id, store_id))
    # reference: https://dba.stackexchange.com/questions/230743/how-do-i-get-a-field-of-the-last-inserted-row#:~:text=You%20can%20use%20LAST_INSERT_ID().&text=With%20no%20argument%2C%20LAST_INSERT_ID(),most%20recently%20executed%20INSERT%20statement.
    cursor.execute('select LAST_INSERT_ID()')
    order_id = cursor.fetchall()

    cursor.execute('insert into orders_product (quantity, orders_id, product_id)\
                   values ({0}, {1}, {2})'.format(quantity, order_id, prod_id))
    
    db.get_db().commit()
    
    return order_id # return order_id (used in 41_view_stores.py)

#POST endpoint. [Steve 1.4, adding product to an order]
@customer.route('/customer/orders/addToOrder', methods= ['POST'])
def post_lfcustomer_add_to_order():
    # collecting data from the request object 
    current_app.logger.info('adding to existing order...')
    the_data = request.json
    current_app.logger.info(the_data)
    cursor = db.get_db().cursor()

    #extracting the variable
    prod_id = the_data['product_id']
    order_id = the_data['order_id']
    quantity = the_data['quantity']

    cursor.execute('insert into orders_product (quantity, orders_id, product_id) \
                   values ({0}, {1}, {2})'.format(quantity, order_id, prod_id))
    
  

    db.get_db().commit()
    
    return 'order created!'


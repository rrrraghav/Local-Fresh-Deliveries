from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db
from backend.ml_models.model01 import predict

analyst = Blueprint('analyst', __name__)
'''
Routes file for handling "analyst" entity endpoints. 
Handles user stories for Josh

'''

# get all analyst information from DB
@analyst.route('/analyst', methods=['GET'])
def get_analysts():
    current_app.logger.info('analyst_routes.py: GET /analyst')
    cursor = db.get_db().cursor()
    cursor.execute('select * from analyst')
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# get a specific analyst's informaion
@analyst.route('/analyst/<analyst_id>', methods=['GET'])
def get_analyst_info(analyst_id):
    current_app.logger.info('analyst_routes.py: GET /analyst<analyst_id>')
    cursor = db.get_db().cursor()
    cursor.execute('select * \
                   from analyst where id = %s', analyst_id)
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get a specific store's order data Josh-1
@analyst.route('/analyst/<analyst_id>/stores/<store_id>/orders', methods=['GET'])
def get_store_orders(analyst_id, store_id):
    current_app.logger.info(f'analyst_routes.py: GET /analyst/<analyst_id>/stores/<store_id>/orders')
    cursor = db.get_db().cursor()
    cursor.execute('select o.id as order_id, o.time_created, o.time_fulfilled, o.pickup_address, o.delivery_address, \
                   c.first_name, c.last_name, p.name as product_name, op.quantity, p.price, \
                   (op.quantity * p.price) as product_total_price \
                   from orders o \
                   join customers c ON o.customer_id = c.id \
                   join orders_product op ON o.id = op.orders_id \
                   join product p ON op.product_id = p.id \
                   where o.store_id = %s ', (store_id,))
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get a specific store's order data Josh-1
@analyst.route('/analyst/<analyst_id>/stores', methods=['GET'])
def get_stores(analyst_id):
    current_app.logger.info(f'analyst_routes.py: GET /analyst/<analyst_id>/stores')
    cursor = db.get_db().cursor()
    cursor.execute('select s.id, s.name, s.phone, sa.address, se.email \
                    from store s \
                    left join store_addresses sa ON s.id = sa.id \
                    left join store_emails se ON s.id = se.id')
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all customers information Josh-4
@analyst.route('/analyst/<analyst_id>/customers', methods=['GET'])
def get_customers(analyst_id):
    current_app.logger.info(f'analyst_routes.py: GET /analyst/<analyst_id>/customers')
    query = 'select * \
        from customers'
    cursor = db.get_db().cursor()
    cursor.execute(query)
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get a specific customer's order data Josh-2
@analyst.route('/analyst/<analyst_id>/customers/<customer_id>/orders', methods=['GET'])
def get_customer_orders(analyst_id, customer_id):
    current_app.logger.info(f'analyst_routes.py: GET /analyst/{analyst_id}/customers/{customer_id}/orders')
    cursor = db.get_db().cursor()
    cursor.execute('select o.id as order_id, o.time_created, o.time_fulfilled, o.pickup_address, o.delivery_address, \
                   s.name as store_name, p.name as product_name, op.quantity, p.price, \
                   (op.quantity * p.price) as product_total_price \
                   from orders o \
                   join store s ON o.store_id = s.id \
                   join orders_product op ON o.id = op.orders_id \
                   join product p ON op.product_id = p.id \
                   where o.customer_id = %s', (customer_id,))
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


# update a specific drivers information Josh-3
@analyst.route('/analyst/<analyst_id>/drivers/<driver_id>', methods=['PUT'])
def update_driver_info(analyst_id, driver_id):
    current_app.logger.info('analyst_routes.py: PUT /analyst/<id>/drivers/<driver_id>')
    analyst_info = request.json
    fn = analyst_info['first_name']
    ln = analyst_info['last_name']
    vt = analyst_info['vehicle_type']
    query = 'update driver set first_name = %s, last_name = %s, vehicle_type = %s \
            where id = %s'
    data = (fn, ln, vt, driver_id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'driver updated by analyst'

# update a specific stores information Josh-3
@analyst.route('/analyst/<analyst_id>/store/<store_id>', methods=['PUT'])
def update_store_info(analyst_id, store_id):
    current_app.logger.info('analyst_routes.py: PUT /analyst/<id>/drivers/<driver_id>')
    analyst_info = request.json
    name = analyst_info['name']
    phone = analyst_info['phone']
    query = 'update store set name = %s, phone = %s\
            where id = %s'
    data = (name, phone, store_id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'store updated by analyst'
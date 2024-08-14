from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db
from backend.ml_models.model01 import predict

drivers = Blueprint('drivers', __name__)
'''
Routes file for handling "driver" entity endpoints. 
Handles user stories for Sally

'''

'''
TODO: finish driver endpoints
# Get all stores from the DB
@drivers.route('/drivers', methods=['GET'])
def get_stores():
    
    current_app.logger.info('driver_routes.py: GET /drivers')
    cursor = db.get_db().cursor()
    cursor.execute('select id, name, phone \
        from store')
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
    
'''

# get all drivers from DB
@drivers.route('/drivers', methods=['GET'])
def get_drivers():
    current_app.logger.info('driver_routes.py: GET /drivers')
    cursor = db.get_db().cursor()
    cursor.execute('select id, first_name, last_name from driver')
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# get a specific driver's informaion
@drivers.route('/drivers/<id>', methods=['GET'])
def get_driver_info(id):
    current_app.logger.info('driver_routes.py: GET /drivers')
    cursor = db.get_db().cursor()
    cursor.execute('select id, first_name, last_name \
                   from driver where id = %s', id)
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# update a specific driver's profile
@drivers.route('/drivers/<id>', methods=['PUT'])
def update_driver_info(id):
    current_app.logger.info('driver_routes.py: GET /drivers/<id>')
    driver_info = request.json
    fn = driver_info['first_name']
    ln = driver_info['last_name']
    vt = driver_info['vehicle_type']
    query = 'update drivers set first_name = %s, last_name = %s, vehicle_type = %s \
            where id = %s'
    data = (fn, ln, vt, id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'driver updated'

# get all orders assigned to a specific driver
@drivers.route('/drivers/<id>/orders', methods=['GET'])
def get_driver_orders(id):
    cursor = db.get_db().cursor()
    cursor.execute('select o.id, o.pickup_address, o.delivery_address \
                   from driver d join orders o on d.id = o.driver_id  \
                   where d.id = %s', id)
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# update information about when an order is fulfilled
@drivers.route('/drivers/<id>/orders/<order_id>', methods=['PUT'])
def update_order_info(id, order_id):
    order_info = request.json
    time_fulfilled = order_info['time_fulfilled']
    query = 'update orders \
        set time_fulfilled = %s \
            where id = %s and driver_id = %s'
    data = (time_fulfilled, order_id, id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'order updated'

''''
TODO: create a route for Sally-2 ->
    As Sally, I want to see the total cost of each delivery I completed and update the status of a delivery when it’s completed.
    Get request with a lot of joins connecting driver to product
'''

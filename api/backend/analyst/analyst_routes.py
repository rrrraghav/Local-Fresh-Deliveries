from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db
from backend.ml_models.model01 import predict

analyst = Blueprint('analyst', __name__)
'''
Routes file for handling "driver" entity endpoints. 
Handles user stories for Sally

'''

# get all analysts from DB
@analyst.route('/analyst', methods=['GET'])
def get_drivers():
    current_app.logger.info('analyst_routes.py: GET /analyst')
    cursor = db.get_db().cursor()
    cursor.execute('select id, first_name, last_name from analyst')
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# get a specific analyst's informaion
@analyst.route('/analyst/<id>', methods=['GET'])
def get_driver_info(id):
    current_app.logger.info('analyst_routes.py: GET /analyst')
    cursor = db.get_db().cursor()
    cursor.execute('select id, first_name, last_name \
                   from analyst where id = %s', id)
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# update a specific driver's profile
@analyst.route('/analyst/<id>', methods=['PUT'])
def update_driver_info(id):
    current_app.logger.info('analyst_routes.py: GET /analyst/<id>')
    analyst_info = request.json
    fn = analyst_info['first_name']
    ln = analyst_info['last_name']
    em = analyst_info['email']
    query = 'update analyst set first_name = %s, last_name = %s, email = %s \
            where id = %s'
    data = (fn, ln, em, id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'analyst updated'

# get all orders assigned to a specific analyst
@analyst.route('/analyst/<id>/orders', methods=['GET'])
def get_analyst_orders(id):
    cursor = db.get_db().cursor()
    cursor.execute('select o.id, o.pickup_address, o.delivery_address \
                   from analyst a join orders o on a.id = o.driver_id  \
                   where a.id = %s', id)
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


'''
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
'''


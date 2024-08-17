from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db
from backend.ml_models.model01 import predict
from datetime import datetime

drivers = Blueprint('drivers', __name__)

# get all driver information from DB
@drivers.route('/drivers', methods=['GET'])
def get_drivers():
    current_app.logger.info('driver_routes.py: GET /drivers')
    cursor = db.get_db().cursor()
    cursor.execute('select * from driver')
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
    cursor.execute('select * \
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
    query = 'update driver set first_name = %s, last_name = %s, vehicle_type = %s \
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
    time = datetime.strptime(time_fulfilled, '%H:%M:%S')
    query = 'update orders \
        set time_fulfilled = %s \
            where id = %s and driver_id = %s'
    data = (time, order_id, id)
    cursor = db.get_db().cursor()
    r = cursor.execute(query, data)
    db.get_db().commit()
    return 'order updated'

# get total cost of a particular order
@drivers.route('/drivers/<id>/orders/<order_id>', methods=['GET'])
def get_order_cost(id, order_id):
    cursor = db.get_db().cursor()
    query = '''
        select o.id, Sum(op.quantity * p.price) as order_cost \
        from driver d join orders o on d.id = o.driver_id \
        join orders_product op on o.id = op.orders_id \
        join product p on op.product_id = p.id \
        where o.id = %s and d.id = %s \
        group by o.id
    '''
    cursor.execute(query, (order_id, id))
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

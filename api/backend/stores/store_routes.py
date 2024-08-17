from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db
from backend.ml_models.model01 import predict

stores = Blueprint('stores', __name__)
'''
Routes file for handling "store" entity endpoints. 
Handles user stories for Steve, Josh, and Max. 

'''
# Get all stores from the DB
@stores.route('/stores', methods=['GET'])
def get_stores():
    
    current_app.logger.info('store_routes.py: GET /stores')
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
    
# Get customer detail for customer with particular store_id
# 
@stores.route('/stores/<store_id>', methods=['GET'])
def get_store(store_id):
    current_app.logger.info('GET /stores/<store_ID> route')
    cursor = db.get_db().cursor()
    #TODO: edit SQL to cater to various personas' user stories' 
    cursor.execute('select id, name, phone \
    from store where id = {0}'.format(store_id))  #in database, table = "store"
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Retrieve all products available at a store 
@stores.route('/stores/<store_id>/products', methods=['GET'])
def get_store_products(store_id):
    current_app.logger.info('GET /stores/<store_ID>/products route')
    cursor = db.get_db().cursor()
    cursor.execute('SELECT p.id, p.name as p_name, p.units_in_stock, p.price, c.name as c_name \
    FROM product p JOIN category c ON p.category_id = c.id \
    JOIN store s ON p.store_id = s.id \
    WHERE s.id = {0} \
    '.format(store_id))  #in database, table = "store". also need "and units_in_stock > 0"
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response



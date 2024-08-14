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
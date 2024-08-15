from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db
from backend.ml_models.model01 import predict

analyst = Blueprint('analyst', __name__)
'''
Routes file for handling "driver" entity endpoints. 
Handles user stories for Sally

'''

# get a specific stores sales data
@analyst.route('/analyst/<analyst_id>/stores/<id>/sales_data', methods=['GET'])
def get_store_data():
    current_app.logger.info('analyst_routes.py: GET /analyst')
    cursor = db.get_db().cursor()
    cursor.execute('select s.name, p.name, p.units_in_stock, p.price \
                    from products p join store s on \
                    where p.id = %s',)
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# # get a specific stores sales data
# @analyst.route('/analyst/<id>/stores/<id>/sales_data', methods=['PUT'])
# def update_driver_info(id):
#     current_app.logger.info('analyst_routes.py: GET /analyst/<id>')
#     analyst_info = request.json
#     fn = analyst_info['first_name']
#     ln = analyst_info['last_name']
#     em = analyst_info['email']
#     query = 'update analyst set first_name = %s, last_name = %s, email = %s \
#             where id = %s'
#     data = (fn, ln, em, id)
#     cursor = db.get_db().cursor()
#     r = cursor.execute(query, data)
#     db.get_db().commit()
#     return 'analyst updated'




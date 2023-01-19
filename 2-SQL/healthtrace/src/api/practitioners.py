from flask import Blueprint, jsonify, abort, request
from ..healthtrace_models import db, Practitioners
import sqlalchemy

bp = Blueprint('practitioners', __name__, url_prefix='/practitioners')


@bp.route('', methods=['GET']) # decorator takes path and list of HTTP verbs
def get_all_practitioners():
    practitioners = Practitioners.query.all() # ORM performs SELECT query
    result = []
    for p in practitioners:
        result.append(p.serialize()) # build list of Tweets as dictionaries
    return jsonify(result) # return JSON response


@bp.route('', methods=['POST'])
def create_practitioner():
    if 'first_name' not in request.json or 'last_name' not in request.json:
        return abort(400)

    practitioner = Practitioners(
        id = request.json['id'],
        first_name = request.json['first_name'],
        last_name = request.json['last_name'],
        specility = request.json['specility'],
        registration_number = request.json['registration_number'],
        phone = request.json['phone'],
        email = request.json['email'],
        created_at = request.json['created_at'],
    )
    try:
        db.session.add(practitioner) 
        db.session.commit()  
        return jsonify(practitioner.serialize())
    except:
        # something went wrong :(
        return jsonify(False)
 

@bp.route('/<int:id>', methods=['GET'])
def get_practitioner_by_id(id: int):
    practitioner = Practitioners.query.get_or_404(id)
    return jsonify(practitioner.serialize())


@bp.route('/<int:id>', methods=['DELETE'])
def delete_practitioner(id: int):
    practitioner = Practitioners.query.get_or_404(id)
    try:
        db.session.delete(practitioner)  
        db.session.commit() 
        return jsonify(message="Practitioner deleted successfully")
    except:
        # something went wrong :(
        return jsonify(False)

@bp.route('/practitioners/<int:practitioner_id>', methods=['PUT', 'PATCH'])
def modify_practitioner(practitioner_id):
    practitioner = Practitioners.query.get_or_404(practitioner_id)
    req_data = request.get_json()
    if 'first_name' not in request.json or 'last_name' not in request.json:
        return abort(400)
        
    practitioner.id = req_data['id']
    practitioner.first_name = req_data['first_name']
    practitioner.last_name = req_data['last_name']
    practitioner.specility = req_data['specility']
    practitioner.registration_number = req_data['registration_number']
    practitioner.phone = req_data['phone']
    practitioner.email = req_data['email']
    practitioner.created_at = req_data['created_at']   
    
    try:
        db.session.commit()
        return jsonify(practitioner.serialize(), message="Practitoner modified successfully")
    except:
        return jsonify(message = "something went wrong :(")
   
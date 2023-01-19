from flask import Blueprint, jsonify, abort, request
from ..healthtrace_models import db, Services
import sqlalchemy

bp = Blueprint('services', __name__, url_prefix='/services')


@bp.route('', methods=['GET']) 
def get_all_services():
    services = Services.query.all() 
    result = []
    for s in services:
        result.append(s.serialize()) 
    return jsonify(result) 


@bp.route('', methods=['POST'])
def create_service():
    if 'service_name' not in request.json:
        return abort(400)

    service = Services(
        id = request.json['id'],
        service_name = request.json['service_name'],
        description  = request.json['description'],
        cost = request.json['cost'],
        service_type = request.json['service_type'],
        provider = request.json['provider'],
        insurance_covered = request.json['insurance_covered'],
        prerequisites = request.json['prerequisites'],
        appointment_length = request.json['appointment_length'],
    )
    try:
        db.session.add(service) 
        db.session.commit()  
        return jsonify(service.serialize())
    except:
        return jsonify(message="something went wrong :(")

@bp.route('/<int:id>', methods=['GET'])
def get_service_by_id(id: int):
    clinic = Services.query.get_or_404(id)
    return jsonify(clinic.serialize())


@bp.route('/<int:id>', methods=['DELETE'])
def delete_service(id: int):
    service = Services.query.get_or_404(id)
    try:
        db.session.delete(service)  
        db.session.commit() 
        return jsonify(message="Service deleted successfully")
    except:
        return jsonify(message="something went wrong :(")

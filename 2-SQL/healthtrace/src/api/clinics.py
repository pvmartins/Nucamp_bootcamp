from flask import Blueprint, jsonify, abort, request
from ..healthtrace_models import Clinics, db
bp = Blueprint('clinics', __name__, url_prefix='/clinics')

@bp.route('', methods=['GET'])
def get_all_clinics():
    clinics = Clinics.query.all()
    result = []
    for c in clinics:
        result.append(c.serialize())
    return jsonify(result) 

@bp.route('', methods=['POST'])
def create_clinic():
    if 'name' not in request.json:
        return abort(400)

    clinic = Clinics(
        id = request.json['id'],
        name = request.json['name'],
        address  = request.json['address'],
        phone = request.json['phone'],
        email = request.json['email'],
        created_at = request.json['created_at'],
    )
    try:
        db.session.add(clinic) 
        db.session.commit()  
        return jsonify(clinic.serialize())
    except:
        return jsonify(message="something went wrong :(")

@bp.route('/<int:id>', methods=['GET'])
def get_clinic_by_id(id: int):
    clinic = Clinics.query.get_or_404(id)
    return jsonify(clinic.serialize())


@bp.route('/<int:id>', methods=['DELETE'])
def delete_clinic(id: int):
    clinic = Clinics.query.get_or_404(id)
    try:
        db.session.delete(clinic)  
        db.session.commit() 
        return jsonify(message="Clinic deleted successfully")
    except:
        return jsonify(message="something went wrong :(")


@bp.route('/clinics/<int:clinic_id>', methods=['PUT', 'PATCH'])
def modify_clinic(clinic_id):
    clinic = Clinics.query.get_or_404(clinic_id)
    req_data = request.get_json()
    if 'name' not in request.json:
        return abort(400)
    
    clinic.id = req_data['id']
    clinic.name = req_data['name']
    clinic.address = req_data['address']
    clinic.phone = req_data['phone']
    clinic.email = req_data['email']
    clinic.created_at = req_data['created_at']
  
    try:
        db.session.commit()
        return jsonify(clinic.serialize(), message="clinic modified successfully")
    except:
        return jsonify(message = "something went wrong :(")
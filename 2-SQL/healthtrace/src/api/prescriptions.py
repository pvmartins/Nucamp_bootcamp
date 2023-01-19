from flask import Blueprint, jsonify, abort, request
from ..healthtrace_models import db, Prescriptions
import sqlalchemy

bp = Blueprint('prescriptions', __name__, url_prefix='/prescriptions')



@bp.route('', methods=['GET']) 
def get_all_prescriptions():
    prescriptions = Prescriptions.query.all() 
    result = []
    for p in prescriptions:
        result.append(p.serialize()) 
    return jsonify(result)


@bp.route('', methods=['POST'])
def create_prescription():
    if 'service_name' not in request.json:
        return abort(400)

    prescription = Prescriptions(
        id = request.json['id'],
        patient_id = request.json['patient_id'],
        practitioner_id  = request.json['practitioner_id'],
        drug_code = request.json['drug_code'],
        drug_name = request.json['drug_name'],
        notes = request.json['notes'],
        service_id = request.json['service_id']
    )
    try:
        db.session.add(prescription) 
        db.session.commit()  
        return jsonify(prescription.serialize())
    except:
        return jsonify(message="something went wrong :(")

@bp.route('/<int:id>', methods=['GET'])
def get_prescription_by_id(id: int):
    prescription = Prescriptions.query.get_or_404(id)
    return jsonify(prescription.serialize())


@bp.route('/<int:id>', methods=['DELETE'])
def delete_prescription(id: int):
    prescription = Prescriptions.query.get_or_404(id)
    try:
        db.session.delete(prescription)  
        db.session.commit() 
        return jsonify(message="Prescription deleted successfully")
    except:
        return jsonify(message="something went wrong :(")

from flask import Blueprint, jsonify, abort, request
from ..healthtrace_models import LaboratoryOrders, db
bp = Blueprint('laboratory_orders', __name__, url_prefix='/laboratory_orders')

@bp.route('', methods=['GET']) 
def get_all_lab_ord():
    laboratory_orders = LaboratoryOrders.query.all()
    result = []
    for l in laboratory_orders:
        result.append(l.serialize()) 
    return jsonify(result)


@bp.route('', methods=['POST'])
def create_lab_ord():
    if 'patient_id' not in request.json or 'practitioner_id' not in request.json:
        return abort(400)

    lab_ord = LaboratoryOrders(
        id = request.json['id'],
        patient_id = request.json['patient_id'],
        practitioner_id  = request.json['practitioner_id'],
        clinic_id = request.json['clinic_id'],
        request_date = request.json['request_date'],
        due_date = request.json['due_date'],
        has_result = request.json['has_result'],
        service_id = request.json['service_id'],
    )
    try:
        db.session.add(lab_ord) 
        db.session.commit()  
        return jsonify(lab_ord.serialize())
    except:
        return jsonify(message="something went wrong :(")

@bp.route('/<int:id>', methods=['GET'])
def get_lab_ord_by_id(id: int):
    lab_ord = LaboratoryOrders.query.get_or_404(id)
    return jsonify(lab_ord.serialize())


@bp.route('/<int:id>', methods=['DELETE'])
def delete_service(id: int):
    lab_ord = LaboratoryOrders.query.get_or_404(id)
    try:
        db.session.delete(lab_ord)  
        db.session.commit() 
        return jsonify(message="Laboratory order deleted successfully")
    except:
        return jsonify(message="something went wrong :(")

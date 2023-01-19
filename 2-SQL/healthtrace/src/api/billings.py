from flask import Blueprint, jsonify, abort, request
from ..healthtrace_models import Billings, db
bp = Blueprint('billings', __name__, url_prefix='/billings')

@bp.route('', methods=['GET'])
def get_all_bills():
    billings = Billings.query.all()
    result = []
    for b in billings:
        result.append(b.serialize())
    return jsonify(result) 



@bp.route('', methods=['POST'])
def create_billing():
    if 'name' not in request.json:
        return abort(400)

    billing = Billings(
        id = request.json['id'],
        patient_id = request.json['patient_id'],
        service_id  = request.json['service_id'],
        cost = request.json['cost'],
        is_paid = request.json['is_paid'],
        transaction_id = request.json['transaction_id'],
    )
    try:
        db.session.add(billing) 
        db.session.commit()  
        return jsonify(billing.serialize())
    except:
        return jsonify(message="something went wrong :(")

@bp.route('/<int:id>', methods=['GET'])
def get_billing_by_id(id: int):
    billing = Billings.query.get_or_404(id)
    return jsonify(billing.serialize())


@bp.route('/<int:id>', methods=['DELETE'])
def delete_billing(id: int):
    billing = Billings.query.get_or_404(id)
    try:
        db.session.delete(billing)  
        db.session.commit() 
        return jsonify(message="Billing deleted successfully")
    except:
        return jsonify(message="something went wrong :(")

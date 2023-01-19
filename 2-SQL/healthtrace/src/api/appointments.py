from flask import Blueprint, jsonify, abort, request
from ..healthtrace_models import Appointments, db
bp = Blueprint('appointments', __name__, url_prefix='/appointments')

@bp.route('', methods=['GET'])
def get_all_appts():
    appointments = Appointments.query.all()
    result = []
    for a in appointments:
        result.append(a.serialize())
    return jsonify(result) 


@bp.route('', methods=['POST'])
def create_appt():

    if 'appt_id' not in request.json or 'practitioner_id' not in request.json:
        return abort(400)
    
    if 'clinic_id' not in request.json or 'date' not in request.json:
        return abort(400)
    
    if 'time' not in request.json or 'status' not in request.json:
        return abort(400)

    appt = Appointments(
        id = request.json['id'],
        appt_id = request.json['appt_id'],
        practitioner_id = request.json['practitioner_id'],
        clinic_id = request.json['clinic_id'],
        date = request.json['date'],
        time = request.json['time'],
        status = request.json['status'],
        created_at = request.json['created_at'],
    )
    try:
        db.session.add(appt) 
        db.session.commit()
        return jsonify(appt.serialize(), message="Appointment deleted successfully")
    except:
        # something went wrong :(
        return jsonify(message = "something went wrong :(")
 


@bp.route('/<int:id>', methods=['GET'])
def get_appt_by_id(id: int):
    appt = Appointments.query.get_or_404(id)
    return jsonify(appt.serialize())


@bp.route('/<int:id>', methods=['DELETE'])
def delete_appt(id: int):
    appt = Appointments.query.get_or_404(id)
    try:
        db.session.delete(appt)  
        db.session.commit() 
        return jsonify(message="Appointment deleted successfully")
    except:
        # something went wrong :(
        return jsonify(message = "something went wrong :(")

@bp.route('/appointments/<int:appointment_id>', methods=['PUT'])
def modify_appt(appointment_id):
    appt = Appointments.query.get_or_404(appointment_id)
    req_data = request.get_json()
    if 'patient_id' not in request.json or 'practitioner_id' not in request.json:
        return abort(400)
    
    if 'clinic_id' not in request.json or 'date' not in request.json:
        return abort(400)
    
    if 'time' not in request.json or 'status' not in request.json:
        return abort(400)

    appt.id = req_data['id']
    appt.patient_id = req_data['patient_id']
    appt.practitioner_id = req_data['practitioner_id']
    appt.clinic_id = req_data['clinic_id']
    appt.date = req_data['date']
    appt.time = req_data['time']
    appt.status = req_data['status']
    appt.created_at = req_data['created_at']

    try:
        db.session.commit()
        return jsonify(appt.serialize(), message="Appointment modified successfully")
    except:
        return jsonify(message = "something went wrong :(")
   
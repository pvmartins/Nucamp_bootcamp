from flask import Blueprint
from flask import Blueprint, jsonify, abort, request
from ..healthtrace_models import Patients, db

bp = Blueprint('patients', __name__, url_prefix='/patients')

@bp.route('', methods=['GET']) 
def get_all_patients():
    patients = Patients.query.all()
    result = []
    for patient in patients:
        result.append(patient.serialize()) 
    return jsonify(result) 

@bp.route('', methods=['POST'])
def create_patient():

    if 'first_name' not in request.json or 'last_name' not in request.json:
        return abort(400)


    # construct User
    user = Patients(
        id = request.json['id'],
        first_name = request.json['first_name'],
        last_name = request.json['last_name'],
        date_of_birth = request.json['date_of_birth'],
        sex_at_birth = request.json['sex_at_birth'],
        phone = request.json['phone'],
        email = request.json['email'],
        home_address = request.json['home_address'],
        occupation = request.json['occupation'],
        preferred_pharmacy = request.json['preferred_pharmacy'],
        blood_type = request.json['blood_type'],
        created_at = request.json['created_at'],
    )
    try:
        db.session.add(user) 
        db.session.commit()  
        return jsonify(user.serialize())
    except:
        # something went wrong :(
        return jsonify(False)
 


@bp.route('/<int:id>', methods=['GET'])
def get_patient_by_id(id: int):
    patient = Patients.query.get_or_404(id)
    return jsonify(patient.serialize())


@bp.route('/<int:id>', methods=['DELETE'])
def delete_patient(id: int):
    patient = Patients.query.get_or_404(id)
    try:
        db.session.delete(patient)  
        db.session.commit() 
        return jsonify(message="Patient deleted successfully")
    except:
        # something went wrong :(
        return jsonify(False)



@bp.route('/patients/<int:patient_id>', methods=['PUT'])
def modify_patient(patient_id):
    patient = Patients.query.get_or_404(patient_id)
    req_data = request.get_json()
    if 'first_name' not in request.json or 'last_name' not in request.json:
        return abort(400)
 
    patient.first_name = req_data['first_name']
    patient.last_name = req_data['last_name']
    patient.date_of_birth = req_data['date_of_birth']
    patient.sex_at_birth = req_data['sex_at_birth']
    patient.phone = req_data['phone']
    patient.email = req_data['email']
    patient.home_address = req_data['home_address']
    patient.occupation = req_data['occupation']
    patient.preferred_pharmacy = req_data['preferred_pharmacy']
    patient.blood_type = req_data['blood_type']
 
    
    try:
        db.session.commit()
        return jsonify(patient.serialize(), message="Patient modified successfully")
    except:
        return jsonify(message = "something went wrong :(")
   
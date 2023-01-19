from flask import Blueprint, jsonify, abort, request
from ..healthtrace_models import Encounters, db
bp = Blueprint('encounters', __name__, url_prefix='/encounters')

@bp.route('', methods=['GET'])
def get_all_encounters():
    encounters = Encounters.query.all()
    result = []
    for encounter in encounters:
        result.append(encounter.serialize())
    return jsonify(result) 

@bp.route('/<int:id>', methods=['GET'])
def get_encounter_by_id(id: int):
    encounter = Encounters.query.get_or_404(id)
    return jsonify(encounter.serialize())

@bp.route('', methods=['POST'])
def create_encounters():

    if 'patient_id' not in request.json or 'practitioner_id' not in request.json:
        return abort(400)
    
    if 'date' not in request.json or 'time' not in request.json:
        return abort(400)

    encounter = Encounters(
        id = request.json['id'],
        patient_id = request.json['patient_id'],
        practitioner_id = request.json['practitioner_id'],
        date = request.json['date'],
        time = request.json['time'],
        type_of_visit = request.json['type_of_visit'],
        encounter_title = request.json['encounter_title'],
    )
    try:
        db.session.add(encounter) 
        db.session.commit()
        return jsonify(encounter.serialize(), message="Encounter created successfully")
    except:
        # something went wrong :(
        return jsonify(message = "something went wrong :(")
 




@bp.route('/<int:id>', methods=['DELETE'])
def delete_encounter(id: int):
    encounter = Encounters.query.get_or_404(id)
    try:
        db.session.delete(encounter)  
        db.session.commit() 
        return jsonify(message="Encounter deleted successfully")
    except:
        # something went wrong :(
        return jsonify(message = "something went wrong :(")

@bp.route('/encounters/<int:encounter_id>', methods=['PUT'])
def modify_encounter(encounter_id):
    encounter = Encounters.query.get_or_404(encounter_id)
    req_data = request.get_json()
    if 'patient_id' not in request.json or 'practitioner_id' not in request.json:
        return abort(400)
    
    if 'clinic_id' not in request.json or 'date' not in request.json:
        return abort(400)
    
    if 'time' not in request.json or 'status' not in request.json:
        return abort(400)

    encounter.id = req_data['id']
    encounter.patient_id = req_data['patient_id']
    encounter.practitioner_id = req_data['practitioner_id']
    encounter.date = req_data['date']
    encounter.time = req_data['time']
    encounter.type_of_visit = req_data['type_of_visit']
    encounter.encounter_title = req_data['encounter_title']

    try:
        db.session.commit()
        return jsonify(encounter.serialize(), message="Encounter modified successfully")
    except:
        return jsonify(message = "something went wrong :(")
   
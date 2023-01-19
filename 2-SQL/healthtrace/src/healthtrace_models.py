from flask_sqlalchemy import SQLAlchemy
import datetime

# creates an object using the SQLAlchemy class and call it db.
db = SQLAlchemy()

# Model is a base class used in the db object to create the tables.
class Patients(db.Model):
    __tablename__ = 'patients'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    first_name = db.Column(db.String(50), unique=False, nullable=False)
    last_name = db.Column(db.String(50),unique=False, nullable=False)
    date_of_birth = db.Column(db.Date(), unique=False, nullable=True)
    sex_at_birth = db.Column(db.String(1), unique=False, nullable=True)
    phone = db.Column(db.VARCHAR(15), unique=False, nullable=True)
    email = db.Column(db.String(100), unique=False, nullable=True)
    home_address = db.Column(db.String(128), unique=False, nullable=True)
    occupation = db.Column(db.String(128), unique=False, nullable=True)
    preferred_pharmacy = db.Column(db.String(128), unique=False, nullable=True)
    blood_type = db.Column(db.VARCHAR(3), unique=False, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.datetime.utcnow, nullable=False)

# Patients table have a One-to-Many Relationship with tables : appointments, encounters, billings, laboratory_orders and prescriptions.


#  The 'Appointments.patient_id' is capitalized because it is referring to the foreign key column in the Appointments table.
#  The column is used to link the two tables together and needs to match exactly, so it is important to use proper capitalization when referring to these columns.

# creates a one-to-many relationship between the Patients table and Appointments table
    # patient_appointments = db.relationship('Appointments', backref='patients', cascade="all,delete", foreign_keys='Appointments.patient_id')
    # patient_encounters = db.relationship('Encounters', backref='patients', cascade="all,delete", foreign_keys='Encounters.patient_id')
    # patient_prescriptions = db.relationship('Prescriptions', backref='patients', cascade="all,delete", foreign_keys='Prescriptions.patient_id')
    # patient_laboratory_orders = db.relationship('LaboratoryOrders', backref='patients', cascade="all,delete", foreign_keys='LaboratoryOrders.patient_id')
    # patient_billings = db.relationship('Billings', backref='patients', cascade="all,delete", foreign_keys='Billings.patient_id')


    def __init__(self, id: int, first_name: str, last_name: str, date_of_birth: str, sex_at_birth: str, phone: str, email: str, home_address: str, occupation: str, preferred_pharmacy:str, blood_type: str, created_at: str ):
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.date_of_birth = date_of_birth
        self.sex_at_birth = sex_at_birth
        self.phone = phone
        self.email = email
        self.home_address = home_address
        self.occupation = occupation 
        self.preferred_pharmacy = preferred_pharmacy
        self.blood_type = blood_type
        self.created_at = created_at

    def serialize(self):
        return {
            'id': self.id,
            'first_name': self.first_name, 
            'last_name': self.last_name,
            'date_of_birth': self.date_of_birth, 
            'sex_at_birth': self.sex_at_birth, 
            'phone': self.phone,
            'email': self.email, 
            'home_address': self.home_address,
            'occupation ': self.occupation,
            'preferred_pharmacy': self.preferred_pharmacy,
            'blood_type': self.blood_type,
            'created_at': self.created_at.isoformat()
            
        }

# Practitioners table have a One-to-Many Relationships appointments,encounters,laboratory orders and prescriptions.

class Practitioners(db.Model):
    __tablename__ = 'practitioners'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    first_name = db.Column(db.String(50), unique=False, nullable=False)
    last_name = db.Column(db.String(50),unique=False, nullable=False)
    specility = db.Column(db.String(50),unique=False, nullable=False)
    registration_number = db.Column(db.VARCHAR(15), unique=False, nullable=True)
    phone = db.Column(db.VARCHAR(15), unique=False, nullable=True)
    email = db.Column(db.String(100), unique=False, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.datetime.utcnow, nullable=False)


    # practitioner_appointments = db.relationship('Appointments', backref='practitioners', cascade="all,delete", foreign_keys='Appointments.practitioner_id')
    # practitiner_encounters = db.relationship('Encounters', backref='practitioners', cascade="all,delete", foreign_keys='Encounters.practitioner_id')
    # practitioner_prescriptions = db.relationship('Prescriptions', backref='practitioners', cascade="all,delete", foreign_keys='Prescriptions.practitioner_id')
    # practitioner_laboratory_orders = db.relationship('LaboratoryOrders', backref='practitioners', cascade="all,delete", foreign_keys='LaboratoryOrdes.practitioner_id')
    # practitioner_billings = db.relationship('Billings', backref='practitioners', cascade="all,delete", foreign_keys='Billings.practitioner_id')

    def __init__(self, id: int, first_name: str, last_name: str, specility: str, registration_number: str, phone: str, email: str, created_at: str):
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.specility = specility
        self.registration_number = registration_number
        self.phone = phone
        self.email = email
        self.created_at = created_at

    def serialize(self):
        return {
            'id': self.id,
            'first_name': self.first_name, 
            'last_name': self.last_name,
            'specility': self.specility, 
            'registration_number': self.registration_number,
            'phone': self.phone,
            'email': self.email, 
            'created_at': self.created_at.isoformat()
            
        }

#  clinics table have a One-to-Many Relationship with laboratory_orders and appointments 

class Clinics(db.Model):
    __tablename__ = 'clinics'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(50),unique=False, nullable=False)
    address = db.Column(db.String(128), unique=False, nullable=True)
    phone = db.Column(db.VARCHAR(15), unique=False, nullable=True)
    email = db.Column(db.String(100), unique=False, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.datetime.utcnow, nullable=False)

    # clinic_appointments = db.relationship('Appointments', backref='clinics', cascade="all,delete", foreign_keys='Appointments.clinics_id')
    # clinic_laboratory_orders = db.relationship('LaboratoryOrders', backref='clinics', cascade="all,delete", foreign_keys='LaboratoryOrders.clinics_id')

    def __init__(self, id: int,name: str,address: str, phone: str, email: str, created_at: str ):
        self.id = id
        self.name = name
        self.address = address 
        self.phone = phone
        self.email = email
        self.created_at = created_at
    
    def serialize(self):
        return {
            'id': self.id,
            'name': self.name,
            'address': self.address,
            'phone': self.phone,
            'email': self.email,
            'created_at': self.created_at
        }

# patients, practitioners and clinics  have a One-to-Many Relationships with appointments

class Appointments(db.Model):
    __tablename__ = 'appointments'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    patient_id = db.Column(db.Integer, db.ForeignKey('patients.id'), nullable=False)
    practitioner_id = db.Column(db.Integer, db.ForeignKey('practitioners.id'), nullable=False)
    clinic_id = db.Column(db.Integer, db.ForeignKey('clinics.id'), nullable=False)
    service_id = db.Column(db.Integer, db.ForeignKey('services.id'), nullable=False)
    date = db.Column(db.Date(), unique=False, nullable=True)
    time = db.Column(db.Time(), unique=False, nullable=True)
    status = db.Column(db.VARCHAR(15), unique=False, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.datetime.utcnow, nullable=False)

# creates a reverse relationship from the Appointments table to the Patients table
    # appointments_patient = db.relationship('Patients', backref=db.backref('appointments', cascade="all,delete"))

    # appointments_practitioner = db.relationship('Practitioners', backref=db.backref('appointments', cascade="all,delete"))
    # appointments_clinic = db.relationship('Clinics', backref=db.backref('appointments', cascade="all,delete"))
    # appointments_service =  db.relationship('Services', backref=db.backref('appointments', cascade="all,delete"))
    
    def __init__(self, id: int, patient_id: int, practitioner_id: int, clinic_id: int, date:str, time: str, status: str, created_at: str):
        self.id = id
        self.patient_id = patient_id
        self.practitioner_id = practitioner_id
        self.clinic_id = clinic_id
        self.date = date
        self.time = time
        self.status = status
        self.created_at = created_at
    
    def serialize(self):
        return {
            'id': self.id,
            'patient_id' : self.patient_id,
            'practitioner_id': self.practitioner_id,
            'clinic_id': self.clinic_id,
            'date': self.date,
            'time': self.time,
            'status': self.status,
            'created_at': self.created_at

        }

# patients, practitioners have a One-to-Many Relationships with encounters

class Encounters(db.Model):
    __tablename__ = 'encounters'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    patient_id = db.Column(db.Integer, db.ForeignKey('patients.id'), nullable=False)
    practitioner_id = db.Column(db.Integer, db.ForeignKey('practitioners.id'), nullable=False)
    date = db.Column(db.Date(), unique=False, nullable=True)
    time = db.Column(db.Time(), unique=False, nullable=True)
    type_of_visit = db.Column(db.VARCHAR(15), unique=False, nullable=False)
    encounter_title = db.Column(db.String(128), unique=False, nullable=True)

    # patients =  db.relationship('Patients', backref='encounters', cascade="all,delete")
    # practitioners =  db.relationship('Practitioners', backref='encounters', cascade="all,delete")

    def __init__(self, id: int,patient_id: int, practitioner_id: int, date: str, time: str, type_of_visit: str, encounter_title: str):
        self.id = id
        self.patient_id = patient_id
        self.practitioner_id = practitioner_id
        self.date = date
        self.time = time
        self.type_of_visit = type_of_visit
        self.encounter_title = encounter_title
        
    
    def serialize(self):
        return {
            'id': self.id, 
            'patient_id': self.patient_id,
            'practitioner_id': self.practitioner_id,
            'date': self.date,
            'time': self.time,
            'type_of_visit': self.type_of_visit,
            'enconter_title': self.encounter_title
        

        }

# patients, practitioners have a One-to-Many Relationships with prescriptions

class Prescriptions(db.Model):
    __tablename__ = 'prescriptions'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    patient_id = db.Column(db.Integer, db.ForeignKey('patients.id'), nullable=False)
    practitioner_id = db.Column(db.Integer, db.ForeignKey('practitioners.id'), nullable=False)
    date = db.Column(db.DateTime, default=datetime.datetime.utcnow, nullable=False)
    drug_code = db.Column(db.VARCHAR(15), unique=False, nullable=False)
    drug_name = db.Column(db.String(128), unique=False, nullable=True)
    notes = db.Column(db.String(128), unique=False, nullable=True)
    service_id = db.Column(db.Integer, db.ForeignKey('services.id'), nullable=False)

    # patients =  db.relationship('Patients', backref='prescriptions', cascade="all,delete")
    # practitioners =  db.relationship('Practitioners', backref='prescriptions', cascade="all,delete")
    # services =  db.relationship('Services', backref='prescriptions', cascade="all,delete")

    def __init__(self, id: int, patient_id: int, practitioner_id: int, date: str, drug_code: str, drug_name: str, notes: str, service_id: int):
        self.id = id 
        self.patient_id = patient_id
        self.practitioner_id = practitioner_id
        self.date = date
        self.drug_code = drug_code
        self.drug_name = drug_name
        self.notes = notes
        self.service_id = service_id
   
    def serialize(self):
        return {
            'id': self.id, 
            'patient_id': self.patient_id,
            'practitioner_id': self.practitioner_id,
            'date': self.date, 
            'drug_code': self.drug_code, 
            'drug_name': self.drug_name, 
            'notes': self.notes,
            'service_id': self.service_id
        }

# patients, practitioners and clinics have a One-to-Many Relationships with laboratory orders

class LaboratoryOrders(db.Model):
    __tablename__ = 'laboratory_orders'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    patient_id = db.Column(db.Integer, db.ForeignKey('patients.id'), nullable=False)
    practitioner_id = db.Column(db.Integer, db.ForeignKey('practitioners.id'), nullable=False)
    clinic_id = db.Column(db.Integer, db.ForeignKey('clinics.id'), nullable=False)
    request_date = db.Column(db.DateTime, default=datetime.datetime.utcnow, nullable=False)
    due_date = db.Column(db.DateTime, default=datetime.datetime.utcnow, nullable=False)
    has_result = db.Column(db.Boolean, default=False, nullable=False)
    service_id = db.Column(db.Integer, db.ForeignKey('services.id'), nullable=False)

    # patients =  db.relationship('Patients', backref='laboratory_orders', cascade="all,delete")
    # practitioners =  db.relationship('Practitioners', backref='laboratory_orders', cascade="all,delete")
    # clinics = db.relationship('Clinics', backref='laboratory_orders', cascade="all,delete")
    # services =  db.relationship('Services', backref='laboratory_orders', cascade="all,delete")
    

    def __init__(self, id: int, patient_id: int, practitioner_id: int, clinic_id: int, request_date: str, due_date: str, has_result: bool, service_id: int):
        self.id = id 
        self.patient_id = patient_id
        self.practitioner_id = practitioner_id
        self.clinic_id = clinic_id 
        self.request_date = request_date
        self.due_date = due_date
        self.has_result = has_result
        self.service_id = service_id
    
    def serialize(self):
        return {
            'id': self.id,
            'patient_id': self.patient_id,
            'practitioner_id': self.practitioner_id,
            'clinic_id': self.clinic_id,
            'request_date': self.request_date,
            'due_date': self.due_date,
            'has_result': self.has_result,
            'service_id': self.service_id,
        }
    


class Services(db.Model):
    __tablename__ = 'services'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    service_name = db.Column(db.String(128), unique=False, nullable=True)
    description = db.Column(db.String(128), unique=False, nullable=True)
    cost = db.Column(db.Integer, nullable=False)
    service_type = db.Column(db.String(128), unique=False, nullable=False)
    provider = db.Column(db.String(128), unique=False, nullable=False)
    insurance_covered = db.Column(db.Boolean, default=False, nullable=False)
    prerequisites = db.Column(db.String(128), unique=False, nullable=False)
    appointment_length = db.Column(db.Integer, nullable=False)

    # service_billings  = db.relationship('Billings', backref='services', cascade="all,delete", foreign_keys='Billings.service_id')
    # service_appointments  = db.relationship('Appointments', backref='services', cascade="all,delete", foreign_keys='Appointments.service_id')

    def __init__(self, id: int, service_name: str, description: str, cost: int, service_type: str, provider: str, insurance_covered: bool, prerequisites: str, appointment_length: int):
        self.id = id 
        self.service_name = service_name
        self.description = description
        self.cost = cost
        self.service_type = service_type
        self.provider = provider
        self.insurance_covered = insurance_covered
        self.prerequisites = prerequisites
        self.appointment_length = appointment_length
  
    def serialize(self):
        return {
            'id': self.id,
            'service_name': self.service_name,
            'description': self.description ,
            'cost': self.cost,
            'service_type': self.service_type,
            'provider': self.provider,
            'insurance_covered': self.insurance_covered,
            'prerequisites': self.prerequisites,
            'appointment_length': self.appointment_length,
        }

# Billings has 
class Billings(db.Model):
    __tablename__ = 'billings'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    patient_id = db.Column(db.Integer, db.ForeignKey('patients.id'), nullable=False)
    service_id = db.Column(db.Integer, db.ForeignKey('services.id'), nullable=False)
    cost = db.Column(db.Integer, nullable=False)
    is_paid = db.Column(db.Boolean, default=False, nullable=False)
    transaction_id = db.Column(db.String(128), unique=False, nullable=True)

    # patients = db.relationship('Patients', backref='billings', cascade="all,delete")
    # services = db.relationship('Services', backref='billings', cascade="all,delete")

    def __init__(self, id: int,patient_id: int, service_id: int, cost: int, is_paid: bool, transaction_id: str):
        self.id = id    
        self.patient_id = patient_id 
        self.service_id = service_id 
        self.cost = cost 
        self.is_paid = is_paid 
        self.transaction_id = transaction_id

    def serialize(self):
        return {
            'id': self.id,
            'patient_id': self.patient_id,
            'service_id': self.service_id,
            'cost': self.cost,
            'is_paid': self.is_paid,
            'transaction_id': self.transaction_id
        }

class Users (db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(50), unique=True, nullable=False)
    password = db.Column(db.String(50), unique=False, nullable=False)
    first_name = db.Column(db.String(128), unique=False, nullable=True)
    last_name = db.Column(db.String(128), unique=False, nullable=True)
    email = db.Column(db.String(128), unique=False, nullable=True)
    phone = db.Column(db.VARCHAR(15), unique=False, nullable=False)
    role = db.Column(db.VARCHAR(15), unique=False, nullable=False)

    def __init__(self, id: int, username: str, password: str, first_name: str, last_name: str, email: str, phone: str, role: str):
        self.id = id 
        self.username = username
        self.password =password 
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.phone = phone 
        self.role = role
    
    def serialize(self):
        return {
            id : self.id,
            'username': self.username,
            'password': self.password,
            'first_name': self.first_name,
            'last_name': self.last_name,
            'email': self.email,
            'phone': self.phone,
            'role': self.role,
        }


   
   #liking_users = db.relationship('User', secondary=likes_table, lazy='subquery',backref=db.backref('liked_tweets', lazy=True))
   #https://flask-sqlalchemy.palletsprojects.com/en/2.x/models/

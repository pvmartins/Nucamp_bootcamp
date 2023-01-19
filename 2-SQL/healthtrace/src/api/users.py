from flask import Blueprint
from flask import Blueprint, jsonify, abort, request
from ..healthtrace_models import Users, db
import hashlib
import secrets
import sqlalchemy

bp = Blueprint('users', __name__, url_prefix='/users')

def scramble(password: str):
    """Hash and salt the given password"""
    salt = secrets.token_hex(16)
    return hashlib.sha512((password + salt).encode('utf-8')).hexdigest()

@bp.route('', methods=['GET'])  
def get_all_users():
    users = Users.query.all()
    result = []
    for user in users:
        result.append(user.serialize())  
    return jsonify(result) 

@bp.route('/<int:id>', methods=['GET'])
def get_user_by_id(id: int):
    user = Users.query.get_or_404(id)
    return jsonify(user.serialize())


@bp.route('', methods=['POST'])
def create_user():
    # req body must contain username and password
    if 'username' not in request.json or 'password' not in request.json:
        return abort(400)
    
    if len(request.json['username']) < 3:
        return abort(400)
        
    
    if len(request.json['password']) < 8:
        return abort(400)

    # construct User
    user = Users(
        username=request.json['username'],
        password=scramble(request.json['password'])
    )
    try:
        db.session.add(user) 
        db.session.commit()  
        return jsonify(user.serialize())
    except:
        # something went wrong :(
        return jsonify(False)
    

@bp.route('/<int:id>', methods=['DELETE'])
def delete_user(id: int):
    user = Users.query.get_or_404(id)
    try:
        db.session.delete(user)  
        db.session.commit() 
        return jsonify(True)
    except:
        # something went wrong :(
        return jsonify(False)


@bp.route('/<int:id>', methods=['PATCH', 'PUT'])
def update_user(id: int):
    user = Users.query.get_or_404(id)
    if 'username' not in request.json or 'password' not in request.json:
        return abort(400)
    
    if len(request.json['username']) < 3 or len(request.json['password'] ) < 8:
        return abort(400)
        
    user.username = request.json['username']
    user.password = scramble(request.json['password'])
    
    try:
        db.session.commit()  # execute UPDATE statement
        return jsonify(user.serialize())
    except:
        # something went wrong :(
        return jsonify(False)

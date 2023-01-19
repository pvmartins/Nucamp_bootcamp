from flask import Blueprint
from flask import Blueprint, jsonify, abort, request
from ..models import User, Tweet, db, likes_table
import hashlib
import secrets
import sqlalchemy

bp = Blueprint('users', __name__, url_prefix='/users')

def scramble(password: str):
    """Hash and salt the given password"""
    salt = secrets.token_hex(16)
    return hashlib.sha512((password + salt).encode('utf-8')).hexdigest()

@bp.route('', methods=['GET'])  # decorator takes path and list of HTTP verbs
def index():
    users = User.query.all()  # ORM performs SELECT query
    result = []
    for user in users:
        result.append(user.serialize())  # build list of Users as dictionaries
    return jsonify(result)  # return JSON response

@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    user = User.query.get_or_404(id)
    return jsonify(user.serialize())


@bp.route('', methods=['POST'])
def create():
    # req body must contain username and password
    if 'username' not in request.json or 'password' not in request.json:
        return abort(400)
    
    if len(request.json['username']) < 3:
        return abort(400)
        
    
    if len(request.json['password']) < 8:
        return abort(400)

    # construct User
    user = User(
        username=request.json['username'],
        password=scramble(request.json['password'])
    )
    try:
        db.session.add(user)  # prepare CREATE statement
        db.session.commit()  # execute CREATE statement
        return jsonify(user.serialize())
    except:
        # something went wrong :(
        return jsonify(False)
    

@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    user = User.query.get_or_404(id)
    try:
        db.session.delete(user)  # prepare DELETE statement
        db.session.commit()  # execute DELETE statement
        return jsonify(True)
    except:
        # something went wrong :(
        return jsonify(False)


@bp.route('/<int:id>', methods=['PATCH', 'PUT'])
def update(id: int):
    user = User.query.get_or_404(id)
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

@bp.route('/<int:id>/liked_tweets', methods=['GET'])
def liked_tweets(id: int):
    u = User.query.get_or_404(id)
    result = []
    for t in u.liked_tweets:
        result.append(t.serialize())
    return jsonify(result)

##### BONUS TASKS #######

# @bp.route('', methods=['POST'])
# def like(tweet_id:str):
#     # req body must contain username and password
#     if 'tweet_id' not in request.json:
#         return abort(400)
    
#     # Check that a user with a matching id exists using get_or_404 ( documentation here)
#     user = User.query.get_or_404(id)
#     # Check that a tweet with a matching tweet_id exists using get_or_404 ( documentation here)
#     tweet = Tweet.query.get_or_404(tweet_id)
    
#     like = User(
#         tweet_id=request.json['tweet_id']
#     )
   
#     stmt = sqlalchemy.insert(users).values(name='spongebob', fullname="Spongebob Squarepants")

#     db.session.commit()  # execute INSERT statement

#     return 

# @bp.route('', methods=['DELETE'])
# def unlike(tweet_id:str):
#     # req body must contain username and password
#     if 'tweet_id' not in request.json:
#         return abort(400)
    
#     # Check that a user with a matching id exists using get_or_404 ( documentation here)
#     user = User.query.get_or_404(id)
#     # Check that a tweet with a matching tweet_id exists using get_or_404 ( documentation here)
#     tweet = Tweet.query.get_or_404(tweet_id)

#     stmt = sqlalchemy.delete(user_table).where(user_table.c.id == id)
    
#     like = User(
#         tweet_id=request.json['tweet_id']
#     )
   
#     stmt = sqlalchemy.insert(user_table).values(name='spongebob', fullname="Spongebob Squarepants")

#     db.session.commit()  # execute INSERT statement

#     return 
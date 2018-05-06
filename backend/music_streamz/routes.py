from flask import jsonify, request, abort
from music_streamz import app
from music_streamz import Db as db
from datetime import datetime
from helpers import *
from constants import *
import json
import requests
import base64
import os


# @app.route('/', methods=['GET'])
# def index():
#   return jsonify({'hello': 'world'})


@app.route('/search', methods=['GET'])
def search():
  q = request.args.get('q')
  q_type = request.args.get('type')
  page = request.args.get('page')

  if q is None:
    abort(400)

  if q_type not in QUERY_TYPES:
    abort(400)

  if page is None:
    page = 1
  elif page.isdigit():
    page = int(page)
  else:
    abort(400)

  query_name = q.replace(' ', '+')

  query_result = query_db_or_online(q, q_type, page)

  return jsonify(query_result)


@app.route('/recommendation', methods=['POST'])
def recommend():
  request_json = request.get_json()
  list_picked_songs = request_json['picked_songs']
  limit = request_json['limit']

  # validate
  if type(list_picked_songs) is not list or type(limit) is not int:
    abort(400)
  
  for d in list_picked_songs:
    if 'song_name' not in d or 'artist_name' not in d:
      abort(400)

  recs = get_recommendations(list_picked_songs, limit=limit)

  return jsonify(recs)

@app.route('/better', methods=['POST'])
def evaluate():
  list_picked_songs = request.get_json()['picked_songs']

  # validate
  if type(list_picked_songs) is not list:
    abort(400)

  answer = get_better_service(list_picked_songs)

  return jsonify(answer)

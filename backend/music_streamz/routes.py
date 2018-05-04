from flask import jsonify, request, abort
from music_streamz import app
from music_streamz import Db as db
from datetime import datetime
from helpers import *
import json
import requests
import base64
import os

@app.route('/', methods=['GET'])
def index():
  return jsonify({ 'hello': 'world' })

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


    results_dict = {}

    for QT in QUERY_TYPES:
        if q_type == QT or q_type is None:
            query_result = query_db_or_online(q, QT, page)
            results_dict[QT + 's'] = query_result

    return jsonify(results_dict)



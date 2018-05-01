from flask import jsonify, request, abort
from music_streamz import app
from music_streamz import Db as db
from datetime import datetime
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
    type = request.args.get('type')
    page = request.args.get('page')

    if q is None:
        abort(400)

    if type == 'song':
        type = 'track'
    elif type not in ['artist', 'album', 'song']:
        type = None

    if page is None or not page.isdigit():
        page = 1
    else:
        page = int(page)

    query_name = q.replace(' ', '+')


    # first check if we've already done this query before
    query_result = query_searches_table(q, type, page)

    # if query_result:
    #   query_result = 


    # first get access_token
    key = os.environ['SPOTIFY_KEY']
    secret = os.environ['SPOTIFY_SECRET']
    token_url = 'https://accounts.spotify.com/api/token'
    headers = {'Authorization': 'Basic ' + base64.b64encode(key + ':' + secret)}
    data = {'grant_type': 'client_credentials'}

    r = requests.post(token_url, headers=headers, data=data)

    if r.status_code != 200:
        abort(400)

    access_token = r.json()['access_token']


    # then get songs
    url = 'https://api.spotify.com/v1/search?q=' + query_name + '&type=album,track'
    headers = {"Authorization": "Bearer " + access_token}

    r = requests.get(url, headers=headers)

    r_json = r.json()

    results = {
        'albums': [album['name'] for album in r_json['albums']['items']],
        'songs': [song['name'] for song in r_json['tracks']['items']]
    }

    if r.status_code != 200:
        abort(400)

    return jsonify(results)



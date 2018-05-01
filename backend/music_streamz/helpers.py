import base64
import requests
import os
from music_streamz import Db as db

QUERY_TYPES = ['track', 'album', 'artist']

def query_db_or_online(q, q_type, page):
  """
  Returns data from DB, if it has been put into the DB. Else,
  query Spotify, add it to the DB, and return the data.

  q (string)
  q_type (string): must be one of ['track', 'album', 'artist']
  page (int)

  return (list of dicts)
  """

  query_result = db.query_searches_table(q, q_type, page)

  # get data from Spotify if it is not in DB and put it in DB
  if not query_result:
    query_result = query_spotify(q, q_type, page)
    db.insert_searches_table(q, q_type, page, query_result)

  return query_result


def query_spotify(q, q_type, page):
  """
  Queries Spotify for a specific query and returns this data.

  q (string)
  q_type (string): must be one of ['track', 'album', 'artist']
  page (int)

  return (list of dicts)
  """

  # first get access_token
  key = os.environ['SPOTIFY_KEY']
  secret = os.environ['SPOTIFY_SECRET']
  token_url = 'https://accounts.spotify.com/api/token'
  headers = {'Authorization': 'Basic ' + base64.b64encode(key + ':' + secret)}
  data = {'grant_type': 'client_credentials'}

  r = requests.post(token_url, headers=headers, data=data)

  if r.status_code != 200:
    raise ValueError('Error getting access token')

  access_token = r.json()['access_token']


  # then get search results
  url = 'https://api.spotify.com/v1/search?q=' + q + '&type=' + q_type
  headers = {"Authorization": "Bearer " + access_token}

  r = requests.get(url, headers=headers)
  if r.status_code != 200:
    raise ValueError('Error querying Spotify')

  results = r.json()[q_type + 's']['items']

  if q_type == 'track':
    mod_results = [
      {
        'track_name': track['name'],
        'artist_name': track['artists'][0]['name'],
        'album_name': track['album']['name'],
        'album_image': track['album']['images'][1]['url'],
        'preview_url': track['preview_url'] if track['preview_url'] else ''
      }
      for track in results
    ]
  elif q_type == 'album':
    mod_results = [
      {
        'album_name': album['name'],
        'artist_name': album['artists'][0]['name'],
        'album_image': album['images'][1]['url']
      }
      for album in results
    ]
  else:
    mod_results = [
      {
        'artist_name': artist['name'],
        'artist_image': artist['images'][1]['url'] if artist['images'] else ''
      }
      for artist in results
    ]

  return mod_results

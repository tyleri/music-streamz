import base64
import requests
import os
from music_streamz import Db as db

QUERY_TYPES = ['song', 'album', 'artist']
RESULTS_PER_PAGE = 15

def check_corresponding(dict_type, dict1, dict2):
  """
  Returns true if the two dictionaries correspond, else false.
  """
  if dict_type == 'song':
    return dict1['song_name'].lower() == dict2['song_name'].lower() and \
           dict1['artist_name'].lower() == dict2['artist_name'].lower()
  elif dict_type == 'album':
    return dict1['album_name'].lower() == dict2['album_name'].lower() and \
           dict1['artist_name'].lower() == dict2['artist_name'].lower()
  elif dict_type == 'artist':
    return dict1['artist_name'].lower() == dict2['artist_name'].lower()
  else:
    raise ValueError("Incorrect dict_type")

def combine_and_dedup(dict_type, list1, list2):
  full_list = list1 + list2
  idx1 = 0
  idx2 = 1
  while idx1 < len(full_list):
    while idx2 < len(full_list):
      if check_corresponding(dict_type, full_list[idx1], full_list[idx2]):
        del full_list[idx2]
      else:
        idx2 += 1

    idx1 += 1
    idx2 = idx1 + 1

  return full_list

def query_db_or_online(q, q_type, page):
  """
  Returns data from DB, if it has been put into the DB. Else,
  query online, add it to the DB, and return the data.

  q (string)
  q_type (string): must be one of ['song', 'album', 'artist']
  page (int): must be >= 1

  return (list of dicts)
  """

  query_result = db.query_searches_table(q, q_type, page)

  # return if it was already found in db
  # if query_result:
  if False:
    return query_result

  # get data from online if it is not in DB and put it in DB
  spotify_results = query_spotify(q, q_type, page)
  applemusic_results = query_applemusic(q, q_type, page)

  query_result = combine_and_dedup(q_type, spotify_results, applemusic_results)

  db.insert_searches_table(q, q_type, page, query_result)
  
  if q_type == 'song':
    for song in query_result:
      db.insert_songs_table(song['song_name'], song['artist_name'], song['spotify_id'], song['applemusic_id'])

  return query_result

def get_spotify_token():
  key = os.environ['SPOTIFY_KEY']
  secret = os.environ['SPOTIFY_SECRET']
  token_url = 'https://accounts.spotify.com/api/token'
  headers = {'Authorization': 'Basic ' + base64.b64encode(key + ':' + secret)}
  data = {'grant_type': 'client_credentials'}

  r = requests.post(token_url, headers=headers, data=data)

  if r.status_code != 200:
    raise ValueError('Error getting access token')

  return r.json()['access_token']


def query_spotify(q, q_type, page):
  """
  Queries Spotify for a specific query and returns this data.

  q (string)
  q_type (string): must be one of ['song', 'album', 'artist']
  page (int)

  return (list of dicts)
  """

  type_mapping = {
    'song': 'track',
    'album': 'album',
    'artist': 'artist'
  }

  access_token = get_spotify_token()

  # get search results
  url = 'https://api.spotify.com/v1/search'
  params = {
    'q': q,
    'type': type_mapping[q_type],
    'limit': RESULTS_PER_PAGE,
    'offset': (page - 1) * RESULTS_PER_PAGE
  }
  headers = {"Authorization": "Bearer " + access_token}

  r = requests.get(url, params=params, headers=headers)
  if r.status_code != 200:
    raise ValueError('Error querying Spotify')

  results = r.json()[type_mapping[q_type] + 's']['items']

  if q_type == 'song':
    mod_results = [
      {
        'spotify_id': track['id'],
        'applemusic_id': '',
        'song_name': track['name'],
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

def query_applemusic(q, q_type, page):
  """
  Queries Apple Music for a specific query and returns this data.

  q (string)
  q_type (string): must be one of ['song', 'album', 'artist']
  page (int)

  return (list of dicts)
  """

  type_mapping = {
    'song': 'songs',
    'artist': 'artists',
    'album': 'albums'
  }

  token = os.environ['APPLEMUSIC_TOKEN']

  url = 'https://api.music.apple.com/v1/catalog/us/search'
  params = {
    'term': q,
    'types': type_mapping[q_type],
    'limit': RESULTS_PER_PAGE,
    'offset': (page - 1) * RESULTS_PER_PAGE
  }
  headers = {"Authorization": "Bearer " + token}

  r = requests.get(url, params=params, headers=headers)
  if r.status_code != 200:
    raise ValueError('Error querying Apple Music')

  results = r.json()['results'][type_mapping[q_type]]['data']

  if q_type == 'song':
    mod_results = [
      {
        'applemusic_id': song['id'],
        'spotify_id': '',
        'song_name': song['attributes']['name'],
        'artist_name': song['attributes']['artistName'],
        'album_name': song['attributes']['albumName'],
        'album_image': song['attributes']['artwork']['url'].replace('{w}', '300').replace('{h}', '300'),
        'preview_url': song['attributes']['previews'][0]['url']
      }
      for song in results
    ]
  elif q_type == 'album':
    mod_results = [
      {
        'album_name': album['attributes']['name'],
        'artist_name': album['attributes']['artistName'],
        'album_image': album['attributes']['artwork']['url'].replace('{w}', '300').replace('{h}', '300'),
      }
      for album in results
    ]
  else:
    mod_results = [
      {
        'artist_name': artist['attributes']['name'],
        'artist_image': ''
      }
      for artist in results
    ]

  return mod_results

def get_recommendations(list_picked_songs):
  """
  list_picked_songs: list of {'song_name': SONG_NAME, 'artist_name': ARTIST_NAME}
  """

  list_picked_ids = []

  for song in list_picked_songs:
    query_result = db.query_songs_table(song['song_name'], song['artist_name'])
    list_picked_ids.append(query_result['spotify_id'])

  access_token = get_spotify_token()

  url = 'https://api.spotify.com/v1/recommendations'
  params = {
    'limit': RESULTS_PER_PAGE,
    'market': 'US',
    'seed_tracks': ','.join(list_picked_ids)
  }
  headers = {"Authorization": "Bearer " + access_token}

  r = requests.get(url, params=params, headers=headers)
  if r.status_code != 200:
    raise ValueError('Error querying Spotify')

  results = r.json()['tracks']

  recs = [
      {
        'spotify_id': track['id'],
        'applemusic_id': '',
        'song_name': track['name'],
        'artist_name': track['artists'][0]['name'],
        'album_name': track['album']['name'],
        'album_image': track['album']['images'][1]['url'],
        'preview_url': track['preview_url'] if track['preview_url'] else ''
      }
      for track in results
  ]

  for song in recs:
    db.insert_songs_table(song['song_name'], song['artist_name'], spotify_id=song['spotify_id'])

  return recs


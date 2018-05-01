
def query_spotify(q, type, page):
  """
  Queries Spotify for a specific query.

  q (string)
  type (string): must be one of ['song', 'album', 'artist']
  page (int)
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


  # then get songs
  if type == 'song':
    type = 'track'

  url = 'https://api.spotify.com/v1/search?q=' + q + '&type=' + type
  headers = {"Authorization": "Bearer " + access_token}

  r = requests.get(url, headers=headers)
  if r.status_code != 200:
    raise ValueError('Error querying Spotify')

  r_json = r.json()

  results = {
    'albums': [album['name'] for album in r_json['albums']['items']],
    'songs': [song['name'] for song in r_json['tracks']['items']]
  }


  return jsonify(results)

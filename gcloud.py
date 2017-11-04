import requests

url = "https://www.googleapis.com/prediction/v1.6/projects/card-game-ccg/trainedmodels"

payload = {
    "id": "language-identifier",
    "storageDataLocation": "bucket-cardgame-ccg/language_id.txt"
}

r = requests.post(url, params=payload)

print(r)
print(r.text)
from flask import Flask
import modules.cardgen as cardgen
import json

app = Flask(__name__)

@app.route("/cards/generate/<qty>")
def generate(qty):
    response = cardgen.generate_card(qty)
    if(response == json.dumps({})):
        return response, 400
    return response

if __name__ == "__main__":
    app.run()


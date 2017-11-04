from flask import Flask
import modules.cardgen as cardgen

app = Flask(__name__)

@app.route("/cards/generate/<qty>")
def generate(qty):
    return cardgen.generate_card(qty)

if __name__ == "__main__":
    app.run()


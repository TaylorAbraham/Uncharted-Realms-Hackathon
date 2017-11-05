from flask import Flask
import modules.cardgen as cardgen
import json
import csv

app = Flask(__name__)

@app.route("/cards/generate/<qty>")
def generate(qty):
    response = cardgen.generate_cards(qty)
    if(response == json.dumps({})):
        return response, 400
    return "" + response + ""

if __name__ == "__main__":
    uinput = ""
    while(uinput != "exit"):
        response = cardgen.generate_cards(3)
        uinput = input("Do you pick card #0, 1, or 2?\n")
        if(uinput.isdigit()):
            if(int(uinput) >= 0 and int(uinput) <= 2):
                response = json.loads(response)
                card = response['cards'][int(uinput)]
                with open('data/cards.csv', 'a') as csvfile:
                    f = csv.writer(csvfile)
                    f.writerow([None, card['POW'], card['HP'], card['CLK'], card['EFF']])
                continue
        print("Invalid input")
    app.run()


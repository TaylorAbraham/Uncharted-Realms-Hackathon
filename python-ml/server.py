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
    # This is a developer mode simulation of arena mode, to be migrated to the game
    uinput = ""
    while(uinput != "exit"):
        response = cardgen.generate_cards(3)
        uinput = input("Do you pick card #0, 1, or 2?\n")
        if(uinput.isdigit()):
            if(int(uinput) >= 0 and int(uinput) <= 2):
                response = json.loads(response)
                with open('data/cards.csv', 'a') as csvfile:
                    f = csv.writer(csvfile)
                    for counter, card in enumerate(response['cards']):
                        # For each card in the response, update its rank based on if it was picked
                        if(counter == int(uinput)):
                            card['RANK'] = 7 # Picked cards get a rank of 7
                        else:
                            card['RANK'] = 4 # Unpicked cards get a rank of 4
                        f.writerow([None, card['POW'], card['HP'], card['CLK'], card['EFF'], card['RANK']])
                continue
        print("Invalid input")
    app.run()


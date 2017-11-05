import numpy as np
import random
import json
# Local libraries
import modules.namegen as namegen
import modules.imagegen as imagegen
import modules.mlnetwork as mlnetwork

csv_name = 'data/cards.csv'

HP_vals = [1]*3 + [2]*5 + [3]*5 + [4]*4 + [5]*3 + [6]*2 + [7]*2 + [8] + [9] + [10]
EFFs = ['Charge'] * 15 + ['Ward'] * 15

# Generates new cards
def generate_cards(num_cards):
    try:
        num_cards = int(num_cards)
    except ValueError:
        return json.dumps({})
    card_dict = {'NAME': [], 'POW': [], 'HP': [], 'IMG': [], 'EFF': []}
    names = []

    # Generate base card attributes, to be costed later
    for x in range(num_cards):

        # If we ran out of names, generate a new batch of 15
        if(names == []):
            names = namegen.generate_names()

        name = random.choice(names)
        card_dict['NAME'].append(name)
        names.remove(name)

        # HP is flat out a random int
        HP = random.choice(HP_vals)
        card_dict['HP'].append(HP)

        # Power is generated based on a gaussian distribution centred at the HP value
        POW = int(round(HP + np.random.normal(0, HP/2, 1)[0], 0))
        if(POW < 0):
            POW = 0
        card_dict['POW'].append(POW)

        img = imagegen.generate_image_url(name)
        card_dict['IMG'].append(img)

        card_dict['EFF'].append(random.choice(EFFs))

    results = mlnetwork.predict_costs(card_dict)

    # Build the JSON for the response
    response = {'cards': []}
    for index, card in results.iterrows():
        response['cards'].append({})
        response['cards'][index]['NAME'] = card['NAME']
        response['cards'][index]['POW'] = card['POW']
        response['cards'][index]['HP'] = card['HP']
        response['cards'][index]['CLK'] = card['CLK']
        response['cards'][index]['EFF'] = card['EFF']
        response['cards'][index]['IMG'] = card['IMG']

    return json.dumps(response)


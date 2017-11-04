import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import statsmodels.formula.api as smf
import sklearn
import random
import json
# Local libraries
import modules.namegen as namegen
import modules.imagegen as imagegen

csv_name = 'data/cards.csv'

HP_vals = [1,1,1,2,2,2,2,3,3,3,3,3,4,4,4,4,5,5,5,6,6,6,7,7,8,8,9,9,10]

# Generates new cards
def generate_card(num_cards):
    num_cards = int(num_cards)
    # Load card data
    data = pd.read_csv(csv_name, index_col=0)

    # Define features
    feature_cols = ['POW', 'HP']
    X = data[feature_cols]
    y = data.CLK

    # Plot features and create line of best fit
    fig, axs = plt.subplots(1, 2, sharey=True)
    data.plot(kind='scatter', x='POW', y='CLK', ax=axs[0], figsize=(16, 8))
    data.plot(kind='scatter', x='HP', y='CLK', ax=axs[1])
    lm = smf.ols(formula='CLK ~ POW + HP', data=data).fit() # Find linear fit
    #fig.show()
    card_dict = {'NAME': [], 'POW': [], 'HP': [], 'IMG': []}
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

    cards = pd.DataFrame(card_dict, columns=['NAME', 'POW', 'HP', 'IMG'])

    # Make predictions and combine the dataframes to form the finished cards
    costs = pd.DataFrame({'CLK': lm.predict(cards).round(0).astype(int)})
    results = pd.concat([cards, costs], axis=1)

    # Build the JSON for the response
    response = {'cards': []}
    for index, card in results.iterrows():
        response['cards'].append({})
        response['cards'][index]['NAME'] = card['NAME']
        response['cards'][index]['POW'] = card['POW']
        response['cards'][index]['HP'] = card['HP']
        response['cards'][index]['CLK'] = card['CLK']
        response['cards'][index]['IMG'] = card['IMG']

    return json.dumps(response)

if __name__ == "__main__":
    cards = generate_card(3)
    print(cards)


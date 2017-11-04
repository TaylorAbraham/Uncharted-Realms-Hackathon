import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import statsmodels.formula.api as smf
from random import randint

# Generates new cards
def generate_card(lm, num_cards):
    card_dict = {'POW': [], 'HP': []}
    # Generate cards
    for x in range(num_cards):
        print(x)
        # HP is flat out a random int
        HP = randint(1, 10)
        card_dict['HP'].append(HP)
        # Power is generated based on a gaussian distribution centred at the HP value
        POW = int(round(HP + np.random.normal(0, HP/2, 1)[0], 0))
        card_dict['POW'].append(POW)
    cards = pd.DataFrame(card_dict, columns=['POW', 'HP'])
    print(cards)
    print("\nPredicated Costs:")
    # Make predictions and combine the dataframes to form the finished cards
    costs = pd.DataFrame({'COST': lm.predict(cards)})
    results = pd.concat([cards, costs], axis=1)
    return results

if __name__ == "__main__":
    # Load card data
    data = pd.read_csv('cards.csv', index_col=0)
    print(data.head())
    print(data.shape)

    # Define features
    feature_cols = ['POW', 'HP']
    X = data[feature_cols]
    y = data.COST

    # Plot features and create line of best fit
    fig, axs = plt.subplots(1, 2, sharey=True)
    data.plot(kind='scatter', x='POW', y='COST', ax=axs[0], figsize=(16, 8))
    data.plot(kind='scatter', x='HP', y='COST', ax=axs[1])
    lm = smf.ols(formula='COST ~ POW + HP', data=data).fit() # Find linear fit
    print(lm.params)
    #fig.show()

    # Generate 20 sample cards
    cards = cardgen.generate_card(lm, 20)
    print(cards)


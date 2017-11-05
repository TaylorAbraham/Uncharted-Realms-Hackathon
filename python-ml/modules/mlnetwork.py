import pandas as pd
from sklearn.linear_model import LinearRegression

csv_name = "data/cards.csv"

def predict_costs(card_dict):
    # Load card data
    df = pd.read_csv(csv_name, index_col=0)

    ## Define features
    # First, convert the EFF list to one hot
    df = pd.concat([df, pd.get_dummies(df['EFF'])], axis=1)
    df = df.drop(['EFF'], axis=1) # Drop the old EFF feature
    print(df)
    X = df.drop(['CLK'], axis=1)
    y = df.CLK

    # Create linear regression and fit it on the pre-existing data
    lr_clf = LinearRegression()
    lr_clf.fit(X, y)

    # Convert the card dict to a DataFrame
    df_cards = pd.DataFrame(card_dict, columns=['NAME', 'POW', 'HP', 'EFF', 'IMG'])
    cards = df_cards
    cards['Charge'] = 0
    cards['Ward'] = 0
    cards = pd.concat([cards, pd.get_dummies(cards['EFF'])], axis=1)
    cards = cards.drop(['EFF'], axis=1) # Drop the old EFF feature
    cards = cards.groupby(lambda x:x, axis=1).sum()
    # Predict costs for each of the cards
    preds = lr_clf.predict(cards.drop(['NAME', 'IMG'], axis=1))

    # Make predictions and combine the dataframes to form the finished cards
    costs = pd.DataFrame({'CLK': preds.round(0).astype(int)})
    results = pd.concat([df_cards, costs], axis=1)
    results = results[['NAME', 'POW', 'HP', 'CLK', 'EFF', 'IMG']] # Reorder columns
    print(results)

    return results


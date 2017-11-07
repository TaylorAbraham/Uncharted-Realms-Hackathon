import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestClassifier

csv_name = "data/cards.csv"

# Predict card costs by fitting existing cards' ATK/DEF and effects against their cost
def predict_costs(card_dict):
    # Load card data
    df = pd.read_csv(csv_name, index_col=0)

    ## Define features
    # First, convert the EFF list to one hot
    df = pd.concat([df, pd.get_dummies(df['EFF'])], axis=1)
    df = df.drop(['EFF'], axis=1) # Drop the old EFF feature
    print(df)
    #print(df)
    X = df.drop(['CLK'], axis=1)
    y = df.CLK

    # Create linear regression and fit it on the pre-existing data
    # This is used for accuracy evaluation later on
    lr_clf = LinearRegression()
    lr_clf.fit(X.drop(['Charge', 'Ward'], axis=1), y)
    ## Create random forest and fit it on the pre-existing data
    rfc = RandomForestClassifier(n_jobs=-1,max_features= 'sqrt' , n_estimators=70, oob_score = True, random_state=2)
    rfc.fit(X, y)

    ## Convert the card dict to a DataFrame
    df_cards = pd.DataFrame(card_dict, columns=['NAME', 'POW', 'HP', 'EFF', 'IMG'])
    cards = df_cards
    cards['Charge'] = 0
    cards['Ward'] = 0
    cards = pd.concat([cards, pd.get_dummies(cards['EFF'])], axis=1)
    cards = cards.drop(['EFF'], axis=1) # Drop the old EFF feature
    cards = cards.groupby(lambda x:x, axis=1).sum()
    # Predict costs for each of the cards
    preds = rfc.predict(cards.drop(['NAME', 'IMG'], axis=1))

    print("------------------------")
    print("Linear Regression Score")
    lin_preds = lr_clf.predict(cards.drop(['NAME', 'IMG', 'Charge', 'Ward'], axis=1))
    lin_preds = np.rint(lin_preds)
    from sklearn.metrics import accuracy_score
    acc_score = accuracy_score(lin_preds, preds)
    print(acc_score)
    if(acc_score == 0.0):
        preds = lin_preds

    ## Make predictions and combine the dataframes to form the finished cards
    costs = pd.DataFrame({'CLK': preds.round(0).astype(int)})
    costs[costs < 0] = 0
    results = pd.concat([df_cards, costs], axis=1)
    results = results[['NAME', 'POW', 'HP', 'CLK', 'EFF', 'IMG']] # Reorder columns


    # Random forest feature importance visualization
    print("\nFeature Importances")
    importances = rfc.feature_importances_
    for i in range(len(X.columns)):
        print(X.columns[i], '\t', importances[i])

    print(results)
    return results


import pandas as pd
df = pd.read_csv("data/housing.csv")
df.dropna().to_csv("data/clean.csv", index=False)

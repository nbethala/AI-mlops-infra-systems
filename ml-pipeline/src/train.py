import pandas as pd
from sklearn.linear_model import LinearRegression
import joblib

df = pd.read_csv("data/clean.csv")
X = df.drop("MedHouseVal", axis=1)
y = df["MedHouseVal"]

model = LinearRegression().fit(X, y)
joblib.dump(model, "models/model.pkl")

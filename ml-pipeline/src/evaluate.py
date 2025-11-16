import pandas as pd, joblib, json
from sklearn.metrics import mean_squared_error

df = pd.read_csv("data/clean.csv")
X = df.drop("MedHouseVal", axis=1)
y = df["MedHouseVal"]

model = joblib.load("models/model.pkl")
rmse = mean_squared_error(y, model.predict(X), squared=False)

with open("metrics/metrics.json", "w") as f:
    json.dump({"rmse": rmse}, f)

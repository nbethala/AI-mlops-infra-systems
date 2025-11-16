# download california housing prices 

from sklearn.datasets import fetch_california_housing
import pandas as pd

data = fetch_california_housing(as_frame=True)
df = data.frame
df.to_csv("ml-pipeline/data/housing.csv", index=False)


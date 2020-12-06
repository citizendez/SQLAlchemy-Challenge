import numpy as np
import os.path
from sqlalchemy.orm import Session
from sqlalchemy import create_engine
import pandas as pd
import json
from flask import Flask, jsonify

#BASE_DIR = os.path.dirname(os.path.abspath(__file__))
#db_path = BASE_DIR +  "\Resources\hawaii.sqlite"
#engine = create_engine(f"sqlite:///{db_path}")
engine = create_engine(f"sqlite:///Resources/hawaii.sqlite")
print(engine)
 

app = Flask(__name__)

# index / home route
@app.route("/")
def home(): 
    return (
        f"Available Routes:<br/>" 
    )  

# additional routes

@app.route('/api/v1.0/test')
def test(): 
    sql = """
        SELECT date, tobs FROM Measurement 
        """ 
    results = pd.read_sql(sql, engine) 
    results_json = results.to_dict(orient='records')
    return  jsonify(results_json)


if __name__ == '__main__':
    app.run(debug=True)
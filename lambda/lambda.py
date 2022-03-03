import logging

from fastapi import FastAPI
from mangum import Mangum

app = FastAPI()

x = [{"id": 1235, "AppName": "MyApp"}]
@app.get("/")
def read_root():
    return {"message": "Hello to the FASTAPI example"}


@app.get("/{_id}")
def get_app_by_id(_id: int):
    for el in x:
        try:
            if el["id"] == _id:
                el.update({"statusCode": 200})
                return el
        except KeyError as e:
            logging.error(e)
    return {"message": f'ID {_id} does not exist', "statusCode": 404}

handler = Mangum(app)
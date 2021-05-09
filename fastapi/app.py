import os
import time
import model
import numpy as np
import cv2
import aiohttp
import torch

from urllib.parse import quote
from fastapi import FastAPI, Request, UploadFile, Form
from fastapi.responses import JSONResponse
from tensorflow.keras.models import load_model

app = FastAPI()
client_session = aiohttp.ClientSession() # Start client session
weights = '../serving/yolov5s_herb_saved_model'
herb_model = load_model(weights)

def results_to_json(results, model):
    return [
        [
            {
                "class": int(pred[5]),
                "class_name": model.model.names[int(pred[5])],
                "normalized_box": pred[:4].tolist(),
                "confidence": float(pred[4]),
            }
            for pred in result
        ]
        for result in results.xyxyn
    ]

@app.on_event("shutdown")
async def cleanup():
    await client_session.close()

@app.post('/api/predict')
async def predict_image(request: Request):
    start_time: float = time.time()
    form = await request.form()
    contents = await form["image"].read()
    img = cv2.imdecode(np.frombuffer(contents, np.uint8), cv2.IMREAD_COLOR)
    herb_class = await model.output_predicted_image(img, client_session, herb_model)
    # byte_im = await model.encode_image(img)

     # Pass predicted image in data uri
    # data_uri = 'data:image/jpg;base64,{}'.format(quote(byte_im))

    result_response = {
        'class': herb_class
    }
    print("Got predicted data in ---" + str(time.time() - start_time) + "seconds ---")
    return JSONResponse(content=result_response)

@app.post("/api/predict/test")
async def process_home_form(request: Request):
    image = await request.form()
    model = torch.hub.load('ultralytics/yolov5', 'yolov5s', pretrained=True)
    results = model( Image.open(BytesIO(await image.read())))
    json_results = results_to_json(results)

    return json_results

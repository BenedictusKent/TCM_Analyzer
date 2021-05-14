import os
import time
import model
import numpy as np
import cv2
import aiohttp
import torch
import base64

from urllib.parse import quote
from fastapi import FastAPI, Request, UploadFile, Form
from fastapi.responses import JSONResponse
from tensorflow.keras.models import load_model

app = FastAPI()
client_session = aiohttp.ClientSession() # Start client session
weights = '../serving/yolov5s_herb2_saved_model'
herb_model = load_model(weights)

@app.on_event("shutdown")
async def cleanup():
    await client_session.close()

@app.post('/api/predict')
async def predict_image(request: Request):
    start_time: float = time.time()
    form = await request.form()
    contents = await form["image"].read()
    img = cv2.imdecode(np.frombuffer(contents, np.uint8), cv2.IMREAD_COLOR)
    herb_class, img = await model.output_predicted_image(img, client_session, herb_model)
    byte_im = await model.encode_image(img)
    # my_string = base64.b64encode(img).decode('ascii')
    print(herb_class)
    result_response = {
        'class': herb_class,
        'image': byte_im
    }
    print("Got predicted data in ---" + str(time.time() - start_time) + "seconds ---")
    return JSONResponse(content=result_response)

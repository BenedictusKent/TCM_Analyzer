import time
import model
import numpy as np
import cv2

from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse
from tensorflow.keras.models import load_model

app = FastAPI()

weights = 'yolov5s_herb_saved_model'
herb_model = load_model(weights)


@app.post('/api/predict')
async def predict_image(request: Request):
    start_time: float = time.time()
    form = await request.form()
    contents = await form["image"].read()
    img = cv2.imdecode(np.frombuffer(contents, np.uint8), cv2.IMREAD_COLOR)
    herb_class, img = await model.output_predicted_image(img, herb_model)
    byte_im = await model.encode_image(img)

    result_response = {
        'class': herb_class,
        'image': byte_im
    }

    print("Got predicted data in ---" + str(time.time() - start_time) + "seconds ---")
    return JSONResponse(content=result_response)

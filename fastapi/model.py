import tensorflow as tf
import numpy as np
import cv2
import json
import os
import time
import colorsys
import torch

from numpy import random
from utils.general import non_max_suppression, scale_coords
from utils.datasets import letterbox
from utils.torch_utils import select_device
from base64 import b64encode
from io import BytesIO
from tensorflow.keras.models import load_model

THIS_FOLDER = os.path.dirname(os.path.abspath(__file__))

# Yolo v5
IMAGE_SIZE = 512
conf_thres = 0.5
stride = 32
device = select_device('')

# Get names and colors
herbs = ['Baikal Skullcap Root', 'Radix Rehmanniae Preparata', 'Pilose Asiabell Root', 'Licorice', 'Two-toothed Achyranthes', 'Dwarf Lilyturf Root Tuber', 
         'Largehead Atractylodes Rhizome', 'Lobed Kudzuvine Root', 'White Mulberry Root-bark', 'Balloonflower Root', 'Medical Dogwood', 'Tuber Fleeceflower Root', 
         'Red Paeoniae Trichocarpae', 'Cassia Bark', 'Chinese Angelica', 'Szechwan Lovage Rhizome', 'Safflower', 'Immature Bitter Orange', 'Common Jujube', 
         'Manchurian Wildginger Herb', 'Weeping Forsythia Fruit', 'Common Yam Rhizome', 'Common Coltsfoot Flower', 'Dried Ginger', 'Prepared Common Monkshood Daughter Root', 
         'Peach Seed', 'Tatarian Aster Root', 'Combined Spicebush Root', 'Tree Peony Bark', 'Barbary Wolfberry', 'Nutmeg', 'Indian Buead Tuckahoe', 'Cassiabarktree Twig', 
         'Florists Dendranthema', 'Ginseng Root', 'Mongolian Milkvetch Root', 'Common Anemarrhena', 'Radix Rehmanniae Recens', "Fortune\'s Drynaria Rhizome", 
         'Ma-yuen Jobstears Seed', 'Chinese Taxillus Herb']

herbs_dict = [
  {
    'class':'X1',
    'engName': 'Baikal Skullcap Root',
    'cnName': '黃苓',
    'thumbnail': 'asset/X1/1.jpg'
  },
  {
    'class':'X2',
    'engName': 'Radix Rehmanniae Preparata',
    'cnName': '熟地黃',
    'thumbnail': 'asset/X2/1.jpg'
  },
  {
    'class':'X3',
    'engName': 'Pilose Asiabell Root',
    'cnName': '黨參',
    'thumbnail': 'asset/X3/1.jpg'
  },
  {
    'class':'X4',
    'engName': 'Licorice',
    'cnName': '甘草',
    'thumbnail': 'asset/X4/1.jpg'
  },
  {
    'class':'X5',
    'engName': 'Two-toothed Achyranthes',
    'cnName': '懷牛膝',
    'thumbnail': 'asset/X5/1.jpg'
  },
  {
    'class':'X6',
    'engName': 'Dwarf Lilyturf Root Tuber',
    'cnName': '麥門冬',
    'thumbnail': 'asset/X6/1.jpg'
  },
  {
    'class':'X7',
    'engName': 'Largehead Atractylodes Rhizome',
    'cnName': '白术',
    'thumbnail': 'asset/X7/1.jpg'
  },
  {
    'class':'X8',
    'engName': 'Lobed Kudzuvine Root',
    'cnName': '野葛',
    'thumbnail': 'asset/X8/1.jpg'
  },
  {
    'class':'X9',
    'engName': 'White Mulberry Root-bark',
    'cnName': '桑白皮',
    'thumbnail': 'asset/X9/1.jpg'
  },
  {
    'class':'X10',
    'engName': 'Balloonflower Root',
    'cnName': '桔梗',
    'thumbnail': 'asset/X10/1.jpg'
  },
  {
    'class':'X11',
    'engName': 'Medical Dogwood',
    'cnName': '山茱萸',
    'thumbnail': 'asset/X11/1.jpg'
  },
  {
    'class':'X12',
    'engName': 'Tuber Fleeceflower Root',
    'cnName': '何首烏',
    'thumbnail': 'asset/X12/1.jpg'
  },
  {
    'class':'X13',
    'engName': 'Red Paeoniae Trichocarpae',
    'cnName': '赤芍',
    'thumbnail': 'asset/X13/1.jpg'
  },
  {
    'class':'X14',
    'engName': 'Cassia Bark',
    'cnName': '桂皮',
    'thumbnail': 'asset/X14/1.jpg'
  },
  {
    'class':'X15',
    'engName': 'Chinese Angelica',
    'cnName': '岷當歸',
    'thumbnail': 'asset/X15/1.jpg'
  },
  {
    'class':'X16',
    'engName': 'Szechwan Lovage Rhizome',
    'cnName': '川芎',
    'thumbnail': 'asset/X16/1.jpg'
  },
  {
    'class':'X17',
    'engName': 'Safflower',
    'cnName': '川紅花',
    'thumbnail': 'asset/X17/1.jpg'
  },
  {
    'class':'X18',
    'engName': 'Immature Bitter Orange',
    'cnName': '枳實',
    'thumbnail': 'asset/X18/1.jpg'
  },
  {
    'class':'X19',
    'engName': 'Common Jujube',
    'cnName': '紅棗',
    'thumbnail': 'asset/X19/1.jpg'
  },
  {
    'class':'X20',
    'engName': 'Manchurian Wildginger Herb',
    'cnName': '細辛根',
    'thumbnail': 'asset/X20/1.jpg'
  },
  {
    'class':'X21',
    'engName': 'Weeping Forsythia Fruit',
    'cnName': '連翹',
    'thumbnail': 'asset/X21/1.jpg'
  },
  {
    'class':'X22',
    'engName': 'Common Yam Rhizome',
    'cnName': '懷山藥',
    'thumbnail': 'asset/X22/1.jpg'
  },
  {
    'class':'X23',
    'engName': 'Common Coltsfoot Flower',
    'cnName': '款冬花',
    'thumbnail': 'asset/X23/1.jpg'
  },
  {
    'class':'X24',
    'engName': 'Dried Ginger',
    'cnName': '乾薑',
    'thumbnail': 'asset/X24/1.jpg'
  },
  {
    'class':'X25',
    'engName': 'Prepared Common Monkshood Daughter Root',
    'cnName': '袍附子',
    'thumbnail': 'asset/X25/1.jpg'
  },
  {
    'class':'X26',
    'engName': 'Peach Seed',
    'cnName': '桃仁',
    'thumbnail': 'asset/X26/1.jpg'
  },
  {
    'class':'X27',
    'engName': 'Tatarian Aster Root',
    'cnName': '紫苑',
    'thumbnail': 'asset/X27/1.jpg'
  },
  {
    'class':'X28',
    'engName': 'Combined Spicebush Root',
    'cnName': '烏藥',
    'thumbnail': 'asset/X28/1.jpg'
  },
  {
    'class':'X29',
    'engName': 'Tree Peony Bark',
    'cnName': '銅陵鳳丹皮',
    'thumbnail': 'asset/X29/1.jpg'
  },
  {
    'class':'X30',
    'engName': 'Barbary Wolfberry',
    'cnName': '寧夏枸杞',
    'thumbnail': 'asset/X30/1.jpg'
  },
  {
    'class':'X31',
    'engName': 'Nutmeg',
    'cnName': '荳蔻',
    'thumbnail': 'asset/X31/1.jpg'
  },
  {
    'class':'X32',
    'engName': 'Indian Buead Tuckahoe',
    'cnName': '茯苓',
    'thumbnail': 'asset/X32/1.jpg'
  },
  {
    'class':'X33',
    'engName': 'Cassiabarktree Twig',
    'cnName': '桂枝',
    'thumbnail': 'asset/X33/1.jpg'
  },
  {
    'class':'X34',
    'engName': 'Florists Dendranthema',
    'cnName': '懷菊花',
    'thumbnail': 'asset/X34/1.jpg'
  },
  {
    'class':'X35',
    'engName': 'Ginseng Root',
    'cnName': '白參',
    'thumbnail': 'asset/X35/1.jpg'
  },
  {
    'class':'X36',
    'engName': 'Mongolian Milkvetch Root',
    'cnName': '北黃耆',
    'thumbnail': 'asset/X36/1.jpg'
  },
  {
    'class':'X37',
    'engName': 'Common Anemarrhena',
    'cnName': '知母',
    'thumbnail': 'asset/X37/1.jpg'
  },
  {
    'class':'X38',
    'engName': 'Radix Rehmanniae Recens',
    'cnName': '生地黃',
    'thumbnail': 'asset/X38/1.jpg'
  },
  {
    'class':'X39',
    'engName': 'Fortune\'s Drynaria Rhizome',
    'cnName': '骨碎補',
    'thumbnail': 'asset/X39/1.jpg'
  },
  {
    'class':'X40',
    'engName': 'Ma-yuen Jobstears Seed',
    'cnName': '薏仁',
    'thumbnail': 'asset/X40/1.jpg'
  },
  {
    'class':'X41',
    'engName': 'Chinese Taxillus Herb',
    'cnName': '桑寄生',
    'thumbnail': 'asset/X41/1.jpg'
  }
]

# herb_class = []
# for i in range(1, 42):
#     temp_herb_class = f"X{i}"
#     herb_class.append(temp_herb_class)

# colors = [[random.randint(0, 255) for _ in range(3)] for _ in herbs]
result = []

async def encode_image(image):
    _, buffer = cv2.imencode(".jpg", image)
    buf = BytesIO(buffer)
    byte_im = b64encode(buf.getvalue()).decode('ascii')
    return byte_im

async def get_prediction(image, client_session,):

    data = json.dumps({
        "signature_name": "serving_default",
        'instances': image.permute(0, 2, 3, 1).numpy().tolist()
    })

    async with client_session.post('http://localhost:8501/v1/models/herb_model:predict', data=data.encode('utf-8')) as response:
        result = await response.json()
        prediction = result['predictions']
        prediction = np.asarray(prediction)

    return prediction

async def output_predicted_image(input_img, client_session, model):
    img_h, img_w, _ = input_img.shape

    # Preprocess image
    pre_img = letterbox(input_img, IMAGE_SIZE, stride=stride)[0]
    pre_img = pre_img[:, :, ::-1].transpose(2, 0, 1)  # BGR to RGB
    pre_img = np.ascontiguousarray(pre_img)

    # Run inference
    img = torch.zeros((1, 3, IMAGE_SIZE, IMAGE_SIZE))  # init img
    img = torch.from_numpy(pre_img)
    img = img.float()  # uint8 to fp16/32
    img /= 255.0  # 0 - 255 to 0.0 - 1.0
    if img.ndimension() == 3:
        img = img.unsqueeze(0)

    # Predict

    pred = model(img.permute(0, 2, 3, 1).numpy(), training=False).numpy()
    # pred = await get_prediction_v5(img, client_session)

    # Denormalize xywh
    pred[..., :4] *= IMAGE_SIZE
    pred = torch.tensor(pred)

    # Apply NMS
    pred = non_max_suppression(pred)

    # thickness = int(0.01*img_w)
    # font_thickness = int(0.002*img_w)
    # font_scale = round(0.001*img_w, 1)
    # if img_w > 1000 or img_h > 1000:
    #      thickness = round(0.002 * (img_w + img_h) / 2) + 1
    #      font_thickness = round(0.002 * (img_w + img_h) / 2) + 1
    #      font_scale = max(font_thickness - 5, 1)

    for i, det in enumerate(pred):  # detections per image
        if len(det):
            # Rescale boxes from img_size to im0 size
            # det[:, :4] = scale_coords(img.shape[2:], det[:, :4], input_img.shape).round()
            det = det.numpy().tolist()
            # Write results
            for *xyxy, conf, cls in reversed(det):
                # Record result class
                if herbs_dict[int(cls)] not in result:
                    result.append(herbs_dict[int(cls)])

                #  # draw a bounding box rectangle and label on the image
                # c1, c2 = (int(xyxy[0]), int(xyxy[1])), (int(xyxy[2]), int(xyxy[3]))
                # input_img = cv2.rectangle(input_img, c1, c2, colors[int(cls)], thickness)
                # text = f"{herbs[int(cls)]}: {round(conf * 100, 2)}%"

                # # calculate text width & height to draw the transparent boxes as background of the text
                # (text_width, text_height) = cv2.getTextSize(text, cv2.FONT_HERSHEY_SIMPLEX, font_scale, font_thickness)[0]
                # text_offset_x = int(xyxy[0]) - 2
                # text_offset_y = int(xyxy[1]) - 4
                # box_coords = ((text_offset_x, text_offset_y), (text_offset_x + text_width + 2, text_offset_y - text_height))
                # overlay = input_img.copy()
                # overlay = cv2.rectangle(overlay, box_coords[0], box_coords[1], colors[int(cls)], cv2.FILLED)

                # # add opacity (transparency to the box)
                # input_img = cv2.addWeighted(overlay, 0.6, input_img, 0.4, 0)

                # # now put the text (label: confidence %)
                # input_img = cv2.putText(input_img, text, (text_offset_x, text_offset_y), cv2.FONT_HERSHEY_SIMPLEX, font_scale, (0, 0, 0), font_thickness)
    return result

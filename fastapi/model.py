import numpy as np
import cv2
import os
import torch

from numpy import random
from utils.general import non_max_suppression, scale_coords
from utils.datasets import letterbox
from utils.torch_utils import select_device
from base64 import b64encode
from io import BytesIO

THIS_FOLDER = os.path.dirname(os.path.abspath(__file__))

# Yolo v5
IMAGE_SIZE = 512
conf_thres = 0.7
stride = 32
device = select_device('')

herbs = ['Baikal Skullcap Root', 'Radix Rehmanniae Preparata', 'Pilose Asiabell Root', 'Licorice', 'Two-toothed Achyranthes', 
        'Dwarf Lilyturf Root Tuber', 'Largehead Atractylodes Rhizome', 'Lobed Kudzuvine Root', 'White Mulberry Root-bark', 'Balloonflower Root', 
        'Medical Dogwood', 'Tuber Fleeceflower Root', 'Red Paeoniae Trichocarpae', 'Cassia Bark', 'Chinese Angelica', 'Szechwan Lovage Rhizome', 
        'Safflower', 'Immature Bitter Orange', 'Common Jujube', 'Manchurian Wildginger Herb', 'Weeping Forsythia Fruit', 'Common Yam Rhizome', 
        'Common Coltsfoot Flower', 'Dried Ginger', 'Prepared Common Monkshood Daughter Root', 'Peach Seed', 'Tatarian Aster Root', 'Combined Spicebush Root', 
        'Tree Peony Bark', 'Barbary Wolfberry', 'Nutmeg', 'Indian Buead Tuckahoe', 'Cassiabarktree Twig', 'Florists Dendranthema', 'Ginseng Root', 'Mongolian Milkvetch Root', 
        'Common Anemarrhena', 'Radix Rehmanniae Recens', "Fortune's Drynaria Rhizome", 'Ma-yuen Jobstears Seed', 'Chinese Taxillus Herb']

colors = [[random.randint(0, 255) for _ in range(3)] for _ in herbs]

async def encode_image(image):
    _, buffer = cv2.imencode(".jpg", image)
    buf = BytesIO(buffer)
    byte_im = b64encode(buf.getvalue()).decode('ascii')
    return byte_im

async def output_predicted_image(input_img, model):
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

    # Denormalize xywh
    pred[..., :4] *= IMAGE_SIZE
    pred = torch.tensor(pred)

    # Apply NMS
    pred = non_max_suppression(pred)

    thickness = int(0.02*img_w)
    font_thickness = int(0.0025*img_w)
    font_scale = round(0.0015*img_w, 1)
    if img_w > 1000 or img_h > 1000:
         thickness = round(0.002 * (img_w + img_h) / 2) + 1
         font_thickness = round(0.002 * (img_w + img_h) / 2) + 1
         font_scale = max(font_thickness - 5, 1)
    result = []
    for i, det in enumerate(pred):  # detections per image
        if len(det):
            # Rescale boxes from img_size to im0 size
            det[:, :4] = scale_coords(img.shape[2:], det[:, :4], input_img.shape).round()
            det = det.numpy().tolist()
            # Write results
            for *xyxy, conf, cls in reversed(det):
                # Record result class
                if conf > conf_thres:
                    if int(cls) not in result:
                        result.append(int(cls))

                    # draw a bounding box rectangle and label on the image
                    c1, c2 = (int(xyxy[0]), int(xyxy[1])), (int(xyxy[2]), int(xyxy[3]))
                    input_img = cv2.rectangle(input_img, c1, c2, colors[int(cls)], thickness)
                    text = f"{herbs[int(cls)]}: {round(conf * 100, 2)}%"

                    # calculate text width & height to draw the transparent boxes as background of the text
                    (text_width, text_height) = cv2.getTextSize(text, cv2.FONT_HERSHEY_SIMPLEX, font_scale, font_thickness)[0]
                    text_offset_x = int(xyxy[0]) - 2
                    text_offset_y = int(xyxy[1]) - 4
                    box_coords = ((text_offset_x, text_offset_y), (text_offset_x + text_width + 2, text_offset_y - text_height))
                    overlay = input_img.copy()
                    overlay = cv2.rectangle(overlay, box_coords[0], box_coords[1], colors[int(cls)], cv2.FILLED)

                    # add opacity (transparency to the box)
                    input_img = cv2.addWeighted(overlay, 0.6, input_img, 0.4, 0)

                    # now put the text (label: confidence %)
                    input_img = cv2.putText(input_img, text, (text_offset_x, text_offset_y), cv2.FONT_HERSHEY_SIMPLEX, font_scale, (0, 0, 0), font_thickness)
    return result, input_img

import os.path
import matplotlib.pyplot as plt

from colorizers import *
import http
# from flask_cors import CORS, cross_origin
from flask import request, Flask, Response, jsonify, abort
import json


app = Flask(__name__)




# def get_weights():
global colorizer_eccv16
colorizer_eccv16 = eccv16(pretrained=True).eval()


def colorise(data):

    try:
        img = load_img(data["path"])
    except:
        return json.dumps(http.HTTPStatus.BAD_REQUEST, ensure_ascii=False).encode('utf8')

    (tens_l_orig, tens_l_rs) = preprocess_img(img, HW=(256, 256))

    out_img_eccv16 = postprocess_tens(tens_l_orig, colorizer_eccv16(tens_l_rs).cpu())

    try:
        plt.imsave(f"/imgs/colorised/{os.path.basename(data['path'])}", out_img_eccv16)
        return json.dumps(http.HTTPStatus.OK, ensure_ascii=False).encode('utf8')
    except:

        return json.dumps(http.HTTPStatus.BAD_REQUEST, ensure_ascii=False).encode('utf8')




@app.route('/colorised', methods=['POST'])
def coloriseee():
    data = request.get_json()
    ret = colorise(data)

    return ret



if __name__ == '__main__':
    # col = Coloriser()
    # get_weights()
    app.run('0.0.0.0', port=2020)


#!/usr/bin/python
# -*- coding: utf-8 -*-
import json
from flask import Flask, jsonify, request, send_file
app = Flask(__name__)

@app.route('/sendjson/<param>', methods=['POST'])
def sendjson(param):
    tag = json.loads(request.get_data())
    data = dict()
    data['地区'] = tag[u'地区'].encode('utf-8')
    if tag[u'地区'] == u'江西':
        data['区市'] = ['南昌市', '九江市', '景德镇市', '上饶市', '鹰潭市', '抚州市', '新余市', '宜春市', '萍乡市', '吉安市', '赣州市']
        data['数据'] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1]
    else:
        data['区市'] = ['北京','天津','上海','重庆','河北','河南','云南','辽宁','黑龙江','湖南','安徽','山东','新疆','江苏','浙江','江西','湖北','广西','甘肃','山西','内蒙古','陕西','吉林','福建','贵州','广东','青海','西藏','四川','宁夏','海南','台湾','香港','澳门']
        data['数据'] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4]
    return jsonify(data)

@app.route('/')
def root():
    return send_file('test.html')

if __name__ == '__main__':
    app.debug = True
    app.run(host='0.0.0.0')

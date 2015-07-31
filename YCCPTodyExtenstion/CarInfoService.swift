//
//  CarInfoService.swift
//  YCCQ
//
//  Created by Liu Feng on 15/7/28.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

import UIKit

class CarInfoService {
   
    class func baoKuanCarList(backcall:([BaoKuanCarInfo]) -> Void) {
        request(Method.GET, "http://www.youche.com/json/app/baokuan")
        .responseJSON { _, _, JSON, _ in
            print(JSON)
            var baokuanInfoList = [BaoKuanCarInfo]()
            if let baokuanList: [[String: AnyObject]] = JSON?.objectForKey("baokuandata") as? [[String: AnyObject]] {
                for baokuanDic in baokuanList {
                    let baokuan = BaoKuanCarInfo()
                    if let carName = baokuanDic["carName"] as? String {
                        baokuan.carName = carName
                    }
                    if let pic = baokuanDic["firstPic"] as? String {
                        baokuan.pic = pic
                    }
                    if let id = baokuanDic["id"] as? Int {
                        baokuan.id = id
                    }
                    if let price = baokuanDic["salePrice"] as? Float {
                        baokuan.price = String(format:"%.2f", price)
                    }
                    baokuanInfoList.append(baokuan)
                }
            }
            print(baokuanInfoList)
            backcall(baokuanInfoList)
        }
    }
}

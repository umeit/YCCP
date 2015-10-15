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
        .responseJSON { response in
            print(response)
            var baokuanInfoList = [BaoKuanCarInfo]()
            if let baokuanList: [[String: AnyObject]] = response.result.value?.objectForKey("baokuandata") as? [[String: AnyObject]] {
                for baokuanJSON in baokuanList {
                    
                    let baokuan = BaoKuanCarInfo()
                    if let carName = baokuanJSON["carName"] as? String {
                        baokuan.carName = carName
                    }
                    if let pic = baokuanJSON["firstPic"] as? String {
                        baokuan.pic = pic
                    }
                    if let id = baokuanJSON["id"] as? Int {
                        baokuan.id = id
                    }
                    if let price = baokuanJSON["salePrice"] as? Float {
                        baokuan.price = price.description
                    }
                    baokuanInfoList.append(baokuan)
                }
            }
            print(baokuanInfoList)
            backcall(baokuanInfoList)
        }
    }
}

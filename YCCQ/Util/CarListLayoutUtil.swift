//
//  CarListLayoutUtil.swift
//  YCCQ
//
//  Created by Liu Feng on 15/8/14.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

import Foundation
import CoreGraphics

class CarListLayoutUtil: NSObject {
    
    class func listSortItemWithIndexPath(indexPath: NSIndexPath) -> String {
        switch indexPath.row {
        case 0:
            return "默认排序";
        case 1:
            return "按价格";
        case 2:
            return "按车龄";
        case 3:
            return "按里程";
        default:
            return "";
        }
    }
}

//
//  HomeLayoutUtil.swift
//  YCCQ
//
//  Created by Liu Feng on 15/8/11.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

class HomeLayoutUtil : NSObject {
    
    static let Banner_Row_Index   = 0
    static let Function_Row_Index = 1
    static let Hot_Row_Index      = 2
    static let Baokuan_Row_Index  = 3
    static let CarType_Row_Index  = 4
    static let CarBrand_Row_Index = 5
    static let CarPrice_Row_Index = 6
    
    /* 功能按钮的 Collection Cell 尺寸 */
    class func functionCollectionCellSizeWithIndexPath(indexPath: NSIndexPath) -> CGSize {
        if iPhone6Standard {
            return CGSizeMake(77, 70);
        }
        else if iPhone6PlusStandard {
            return CGSizeMake(87, 82);
        }
        else {
            return CGSizeMake(64, 63);
        }
    }
    
    /* 降价车辆的 Collection Cell 尺寸 */
    class func baokuanCollectionCellSizeWithIndexPath(indexPath: NSIndexPath) -> CGSize {
        if iPhone6Standard {
            return CGSizeMake(170, 170)
        }
        else if iPhone6PlusStandard {
            return CGSizeMake(190, 180);
        }
        else {
            return CGSizeMake(150, 150);
        }
    }
    
    /* 主页每个 ROW 的高度 */
    class func homeTableRowHightWithIndexPath(indexPath: NSIndexPath, baokuanCount: Int) -> Float {
        if iPhone6Standard {
            switch indexPath.row {
            case Banner_Row_Index:
                return 170
            case Function_Row_Index:
                return 248
            case Hot_Row_Index:
                return 206
            case Baokuan_Row_Index:
                return baokuanCount < 4 ? 234 : 410
            case CarType_Row_Index:
                return 122
            case CarBrand_Row_Index:
                return 200
            case CarPrice_Row_Index:
                return 142
            default:
                return 0
            }
        }
        else if iPhone6PlusStandard {
            switch indexPath.row {
            case Banner_Row_Index:
                return 170
            case Function_Row_Index:
                return 268
            case Hot_Row_Index:
                return 206
            case Baokuan_Row_Index:
                return baokuanCount < 4 ? 248 : 436
            case CarType_Row_Index:
                return 122
            case CarBrand_Row_Index:
                return 200
            case CarPrice_Row_Index:
                return 150
            default:
                return 0
            }
        }
        else {
            switch indexPath.row {
            case Banner_Row_Index:
                return 150
            case Function_Row_Index:
                return 238
            case Hot_Row_Index:
                return 172
            case Baokuan_Row_Index:
                return baokuanCount < 4 ? 210 : 374
            case CarType_Row_Index:
                return 122
            case CarBrand_Row_Index:
                return 200
            case CarPrice_Row_Index:
                return 142
            default:
                return 0
            }
        }
    }
}

//
//  HomeLayoutUtil.swift
//  YCCQ
//
//  Created by Liu Feng on 15/8/11.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

import Foundation

class HomeLayoutUtil {
    
    let Banner_Row_Index   = 0
    let Function_Row_Index = 1
    let Baokuan_Row_Index  = 2
    let CarType_Row_Index  = 3
    let CarBrand_Row_Index = 4
    let CarPrice_Row_Index = 5
    
    func homeTableRowHightWithIndexPath(indexPath: NSIndexPath, baokuanCount: Int) -> Float {
        if iPhone6 {
            switch indexPath.row {
            case Banner_Row_Index:
                return 170
            case Function_Row_Index:
                return 248
            case Baokuan_Row_Index:
                return baokuanCount < 4 ? 234 : 410
            case CarType_Row_Index:
                return 122
            case CarBrand_Row_Index:
                return 200
            case CarPrice_Row_Index:
                return 142
            default:
                print("")
            }
        }
        return 0
    }
}

//
//  SystemUtil.swift
//  YCCQ
//
//  Created by Liu Feng on 15/8/11.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

import UIKit

//let iPhone6 = ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

//#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)


let iPhone6 = CGSizeEqualToSize(CGSizeMake(750, 1334), UIScreen.mainScreen().currentMode!.size)

let iPhone6Plus =  CGSizeEqualToSize(CGSizeMake(1125, 2001), UIScreen.mainScreen().currentMode!.size)
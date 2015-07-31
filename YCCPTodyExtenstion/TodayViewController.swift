//
//  TodayViewController.swift
//  YCCPTodyExtenstion
//
//  Created by Liu Feng on 15/7/28.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var carImageView: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        CarInfoService.baoKuanCarList({(list: [BaoKuanCarInfo]) in
            print(list)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    

    @IBAction func nextButtonPress(sender: AnyObject) {
        
    }

    @IBAction func prevButtonPress(sender: AnyObject) {
        
    }
}

//
//  TodayViewController.swift
//  YCCPTodyExtenstion
//
//  Created by Liu Feng on 15/7/28.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carNameLabel: UILabel!
    var currentIndex: Int = 0
    var baokuanCarInfoList: [BaoKuanCarInfo]?
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CarInfoService.baoKuanCarList({(list: [BaoKuanCarInfo]) in
            self.baokuanCarInfoList = list
            
            // 显示第一张图片
            self.showBaokuanCarInfoWithCurrentIndex()
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    

    // MARK: - Privatre
    private func showBaokuanCarInfoWithCurrentIndex() {
        if let baokuanCarInfo = self.baokuanCarInfoList?[self.currentIndex] {
            let imageURLStr = "http://file.youche.com/_100_100" + baokuanCarInfo.pic!
            let data = NSData(contentsOfURL: NSURL(string: imageURLStr)!)
            let image = UIImage(data: data!)
            self.carImageView.image = image
            self.carNameLabel.text = baokuanCarInfo.carName
        }
    }
    
    
    
    // MARK: - Action
    @IBAction func nextButtonPress(sender: AnyObject) {
        if let carInfoListCount = self.baokuanCarInfoList?.count {
            if currentIndex + 1 < carInfoListCount {
                self.currentIndex++
            }
            else {
                self.currentIndex = 0
            }
            self.showBaokuanCarInfoWithCurrentIndex()
        }
    }

    @IBAction func prevButtonPress(sender: AnyObject) {
        if let carInfoListCount = self.baokuanCarInfoList?.count {
            if self.currentIndex - 1 >= 0 {
                self.currentIndex--
            }
            else {
                self.currentIndex = carInfoListCount - 1
            }
            self.showBaokuanCarInfoWithCurrentIndex()
        }
    }
}

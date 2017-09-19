//
//  ViewController.swift
//  Countdown
//
//  Created by redtwowolf on 18/09/2017.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // countdown 10 seconds
        let terminate = Date(timeIntervalSinceNow: 10).timeIntervalSince1970

        CountDown.default.start(terminate: Int(terminate), onMain: { (sec) in
            self.timeLabel.text = "距离地球💥还有" + sec.dhms + "😱😱😱"
        }) { 
           self.timeLabel.text = "倒计时结束了，怎么没💥💥😿😿😿"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


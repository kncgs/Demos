//
//  ViewController.swift
//  CoreAnimationDemo
//
//  Created by redtwowolf on 19/09/2017.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rememberView = RememberView.loadFromNib()
        rememberView.center = view.center
        view.addSubview(rememberView)
    }
}


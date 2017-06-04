//
//  ViewController.swift
//  MasonryCell
//
//  Created by PaoHaiLe on 3/21/16.
//  Copyright © 2016 CoderDB. All rights reserved.
//

import UIKit


// Test git tags

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var names = ["erer", "sansan", "sisisi"]
    var datasource = ["Test git tags",
        
        "英国海外战略要地直布罗陀的机场设计很有特色，一条马路横穿机场跑道而过，每当飞机起降，马路便要封锁。面对C17运输机这样体量的家伙起落，路上的行人车辆更是要“退避三舍”。",
        
        "英国海外战略要地直布罗陀的机场设计很有特色，一条马路横穿机场跑道而过，每当飞机起降，马路便要封锁。面对C17运输机这样体量的家伙起落，路上的行人车辆更是要“退避三舍”。英国海外战略要地直布罗陀的机场设计很有特色，一条马路横穿机场跑道而过，每当飞机起降，马路便要封锁。面对C17运输机这样体量的家伙起落，路上的行人车辆更是要“退避三舍”。英国海外战略要地直布罗陀的机场设计很有特色，一条马路横穿机场跑道而过，每当飞机起降，马路便要封锁。面对C17运输机这样体量”。"]
    
    var tableView: UITableView!
    let Identifier = "TableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
    }
    func addTableView() {
        
        tableView = UITableView(frame: self.view.frame, style: .Grouped)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
//        tableView.snp_makeConstraints { [unowned self](make) -> Void in
//            make.edges.equalTo(self.view)
//        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: Identifier)
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Identifier) as! TableViewCell
        cell.nameLabel.text = names[indexPath.row]
        cell.commentLabel.text = datasource[indexPath.row]
        
//        cell.setNeedsUpdateConstraints()
//        cell.updateConstraintsIfNeeded()
        return cell
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let cell = tableView.dequeueReusableCellWithIdentifier(Identifier) as! TableViewCell
//        cell.setNeedsLayout()
//        cell.layoutIfNeeded()
        
//        return UITableViewAutomaticDimension
//        return UITableViewAutomaticDimension
//    }
    

}


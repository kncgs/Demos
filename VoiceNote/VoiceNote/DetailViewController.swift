//
//  DetailViewController.swift
//  VoiceNote
//
//  Created by Dongbing Hou on 28/10/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {

    
    var tableView: UITableView!
    let identifier = "RecorderCell"
    var datasource = [RecorderModel]()
    var audioPlayer: AVAudioPlayer?
    
    // for btn status
    var indexPathRow = -2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        
        addTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        datasource = StoreManager.default.allData()
    }
    func addTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        tableView.tableFooterView = UIView()
    }

}

// MARK: UITableViewDataSource
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? RecorderCell

        let model = datasource[indexPath.row]
        cell?.model = model
        
        configCellStatus(cell: cell!, model: model, idx: indexPath)
        return cell!

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
        
    }
    
    func configCellStatus(cell: RecorderCell, model: RecorderModel, idx: IndexPath) {
        
        cell.playOrPauseState = { [unowned self] btn in
            if self.indexPathRow >= 0 {
                self.datasource[self.indexPathRow].isPlaying = false
            }
            btn.isSelected = !btn.isSelected
            model.isPlaying = btn.isSelected
            if btn.isSelected {
                self.playRecoder(name: model.name!)
            } else {
                self.stopRecoder(name: model.name!)
            }
            
            let lastIdx = IndexPath(row: self.indexPathRow, section: 0)
            self.tableView.reloadRows(at: [lastIdx, idx], with: .none)
            if model.isPlaying == true {
                self.indexPathRow = idx.row
            }
        }
    }

    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, idx) in
            let model = self.datasource[indexPath.row]
            StoreManager.default.delete(model: model)
            self.datasource.remove(at: indexPath.row)
            tableView.deleteRows(at: [idx], with: .top)
        }
        return [deleteAction]
    }
}

// MARK: UITableViewDataSource
extension DetailViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let cell = tableView.cellForRow(at: IndexPath(item: indexPathRow, section: 0)) as! RecorderCell
        cell.playButton.isSelected = false
        datasource[indexPathRow].isPlaying = false
    }
}

// MARK: Play/Pause
extension DetailViewController {
    func playRecoder(name: String) {
        if audioPlayer != nil {
            PlayerTool.stop(name: datasource[indexPathRow].name!)
            audioPlayer = nil
        }
        audioPlayer = try! PlayerTool.playRecord(name: name)
        audioPlayer?.delegate = self
    }
    func stopRecoder(name: String) {
        PlayerTool.stop(name: name)
    }
}

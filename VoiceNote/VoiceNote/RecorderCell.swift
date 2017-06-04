//
//  RecorderCell.swift
//  VoiceNote
//
//  Created by Dongbing Hou on 28/10/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit
import AVFoundation

class RecorderCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    @IBAction func playOrPause(_ sender: UIButton) {
        playOrPauseState?(sender)
  
    }
    var playOrPauseState: ((UIButton) -> ())?
    
    var model: RecorderModel! {
        didSet {
            nameLabel.text = model.name
            playButton.isSelected = model.isPlaying
        }
    }
    
    
}

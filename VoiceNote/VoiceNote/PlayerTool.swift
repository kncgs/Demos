
//  PlayerTool.swift
//  VoiceNote
//
//  Created by Dongbing Hou on 28/10/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit
import AVFoundation


enum PlayerError: Error {
    case InitFailed
}


class PlayerTool: NSObject {
    
    static var audioPlayerDict = [String : AVAudioPlayer]()
    
    static func playRecord(name: String) throws -> AVAudioPlayer {
        var audioPlayer = audioPlayerDict[name]
        
        if audioPlayer == nil {
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(name)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer!.play()
            } catch PlayerError.InitFailed {
                throw PlayerError.InitFailed
            }
        } else {
//            audioPlayer!.prepareToPlay()
            if (audioPlayer!.isPlaying == false) {
                audioPlayer!.play()
            }
        }
        audioPlayerDict[name] = audioPlayer
        return audioPlayer!
    }
    
    class func pause(name: String) {
        let audioPlayer = audioPlayerDict[name]
        if audioPlayer!.isPlaying {
            audioPlayer!.pause()
        }
    }
    
    class func stop(name: String) {
        let audioPlayer = audioPlayerDict[name]
        if audioPlayer!.isPlaying {
            audioPlayer!.stop()
        }
        audioPlayerDict.removeValue(forKey: name)
    }
    

}

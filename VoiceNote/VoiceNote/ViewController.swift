//
//  ViewController.swift
//  VoiceNote
//
//  Created by Dongbing Hou on 28/10/2016.
//  Copyright © 2016 Dongbing Hou. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class ViewController: UIViewController {
    
    var audioRecoder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    @IBOutlet weak var circleImgView: UIImageView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    func recorderPath() -> URL {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let recordingName = formatter.string(from: Date()) + ".caf"
        print(recordingName)
        
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[0].appendingPathComponent(recordingName)
    }
    
    let recordSettings = [
        AVSampleRateKey: NSNumber(value: Float(44100.0)),
        AVFormatIDKey: NSNumber(value: Int32(kAudioFormatMPEG4AAC)),
        AVNumberOfChannelsKey: NSNumber(value: 1),
        AVEncoderAudioQualityKey: NSNumber(value: Int32(AVAudioQuality.medium.rawValue))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(true)
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch {
            fatalError("session init failed")
        }
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(recordBtnPressed))
        longPress.minimumPressDuration = 1.0
        recordButton.addGestureRecognizer(longPress)
        
    }
    
    @IBAction func playBtnClicked() {
        let model = StoreManager.default.allData().last!
        audioPlayer = try! PlayerTool.playRecord(name: model.name!)   
    }
}


//MARK: Recoder
extension ViewController {
    func recordBtnPressed(_ press: UILongPressGestureRecognizer) {
        if press.state == .began {
            startRecord()
        }
        if press.state == .ended {
            stopRecord()
        }
    }
    func startRecord() {
        do {
            try audioRecoder = AVAudioRecorder(url: recorderPath(), settings: recordSettings)
            audioRecoder.record()
            startAnimation(time: 2.0)
        } catch {
            fatalError("recoder init failed")
        }
    }
    func stopRecord() {
        if audioRecoder.isRecording {
            audioRecoder.stop()
            stopAnimation()
            
            let model = RecorderModel()
            model.name = audioRecoder.url.absoluteString.components(separatedBy: "/").last
            StoreManager.default.insert(model: model)
        }
    }
}

//MARK: Animation
extension ViewController {
    func startAnimation(time: CFTimeInterval) {
        playButton.isHidden = true
        circleImgView.isHighlighted = true
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = M_PI * 2.0
        rotation.duration = time
        rotation.isCumulative = true
        rotation.repeatCount = HUGE
        circleImgView.layer.add(rotation, forKey: "rotationAnimation")
    }
    func stopAnimation() {
        circleImgView.layer.removeAllAnimations()
        circleImgView.isHighlighted = false
        playButton.isHidden = false
    }
}

















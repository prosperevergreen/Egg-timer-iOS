//
//  ViewController.swift
//  EggTimer
//
//  Created by Prosper Evergreen on 23/06/2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    var IncRate: Float = 0.0
    var timerCounter = Timer()
    var hardness: String = ""
    let eggTimes = ["Soft": 300, "Medium": 7, "Hard": 12]
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var timerProgessBar: UIProgressView!
    
    
    //action when button clicked
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        hardness = sender.currentTitle!
        timerCounter.invalidate()
        timerProgessBar.progress = 0
        infoLabel.text = hardness
        
        IncRate = 1/Float(eggTimes[hardness]!)
        timerCounter = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCountdown), userInfo: nil, repeats: true)
    }
    
    
    //progress function
    @objc func timerCountdown(){
        
        timerProgessBar.progress += IncRate
        
        if timerProgessBar.progress == 1 {
            timerCounter.invalidate()
            infoLabel.text = "DONE!!!"
            playSound()
        }
    }
    
    //sound function
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}

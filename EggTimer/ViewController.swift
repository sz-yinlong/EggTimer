//
//  ViewController.swift
//  EggTimer

import AVFoundation
import Foundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer?
    
    @IBAction func hardnessSelect(_ sender: UIButton) {
        
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        
        
       timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if secondsPassed < totalTime {
            
            
            secondsPassed += 1
            progressBar.progress = Float (secondsPassed) /  Float (totalTime)
           
           
           
            
        } else {
             func playSound() {
                guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
                    return }
                let url = URL(fileURLWithPath: path)

                do {
                    player = try AVAudioPlayer(contentsOf: url)
                    player?.play()
                    
                } catch let error {
                    print(error.localizedDescription)
                }
            }
           
            timer.invalidate()
            titleLabel.text = "Done!"
            playSound()
            
            
            
        }
    }
    @IBOutlet weak var progressBar: UIProgressView!
}


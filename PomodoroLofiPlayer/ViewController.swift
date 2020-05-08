//
//  ViewController.swift
//  PomodoroLofiPlayer
//
//  Created by Michael Chang on 2020-05-07.
//  Copyright © 2020 Michael Chang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var audioPlayer = AVAudioPlayer()
    var timer = Timer()
    var isTimerStarted = false
    var time = 1521
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let lofi = Bundle.main.path(forResource: "Fall_In_Love", ofType: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: lofi!))
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [AVAudioSession.CategoryOptions.duckOthers])
        } catch {
            print(error)
        }
    }

    // Desc: Pause and resume the timer and audio
    @IBAction func startButtonTapped(_ sender: Any)
    {
        cancelButton.isEnabled = true
        cancelButton.alpha = 1.0
        if !isTimerStarted
        {
            startTimer()
            isTimerStarted = true
            startButton.setTitle("Pause", for: .normal)
            startButton.setTitleColor(UIColor.orange, for: .normal)
            audioPlayer.play()
        }
        else
        {
            timer.invalidate()
            audioPlayer.pause()
            
            isTimerStarted = false
            
            startButton.setTitle("Resume", for: .normal)
            startButton.setTitleColor(UIColor.green, for: .normal)
        }
    }
    
    // Desc: reset the time and audio when user tap cancel
    @IBAction func cancelButtonTapped(_ sender: Any)
    {
        cancelButton.isEnabled = false
        cancelButton.alpha = 0.5
        startButton.setTitle("Start", for: .normal)
        timer.invalidate()
        time = 1521
        audioPlayer.currentTime = 0
        audioPlayer.pause()
        isTimerStarted = false
        timeLabel.text = "25:21"
    }
    
    // Desc: Start time
    func startTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    // Desc: Slowly decrease time
    @objc func updateTimer()
    {
        time -= 1
        timeLabel.text = formatTime()
    }
    
    // Desc: formatting the time label as the time update
    func formatTime() -> String
    {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
}


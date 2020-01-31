//
//  StopWatchViewController.swift
//  ClockProject3
//
//  Created by Matthew Patterson on 11/24/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//

import UIKit

class StopWatchViewController: UIViewController {


    var time = 0.0
    var timer = Timer()
    var isRunning = false
    
    @IBOutlet weak var watchTime: UILabel!
    

    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        time = UserDefaults.standard.double(forKey: "stopWatchTime") 
        watchTime.text = String(format: "%.2f", time)
        stopButton.isEnabled = false

        
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        if(isRunning) {
            return
        }
        
        startButton.isEnabled = false
        stopButton.isEnabled = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { timer in
            self.updateTime()

        })
    }
    @IBAction func stopButtonTapped(_ sender: Any) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        timer.invalidate()
        isRunning = false
        UserDefaults.standard.set(time, forKey: "stopWatchTime")
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        timer.invalidate()
        isRunning = false
        time = 0.0
        watchTime.text = String(format: "%.2f", time)
        UserDefaults.standard.set(time, forKey: "stopWatchTime")
    }
    func updateTime() {
        time = time + 0.01
        watchTime.text = String(format: "%.2f", time)
    }

}

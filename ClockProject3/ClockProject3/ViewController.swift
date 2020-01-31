//
//  ViewController.swift
//  ClockProject3
//
//  Created by Matthew Patterson on 11/22/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentSetTimeZone: UILabel! //Outlet displays set timezone
    @IBOutlet weak var digitalClock: UILabel!       //Outlet displays digital clock time
    
    let date = Date()
    let calendar = Calendar.current
    
    let dateFormatter = DateFormatter()
    
    

    @IBAction func timeZonePressed(_ sender: Any) {                 //segue to timezone screen
        performSegue(withIdentifier: "showTimeZones", sender: nil)
    }

    @IBAction func stopWatch(_ sender: Any) {
        
        performSegue(withIdentifier: "showStopWatch", sender: nil)  //segue to stopwatch
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        dateFormatter.dateFormat = "h:mm:ss a"              //dateformatter for digital clock
        let myString = dateFormatter.string(from: Date())   //convert date to string
        digitalClock.text = myString                        //display time
        _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { timer in
            self.updateTime()                               //timer loop updates time every half second
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let timeZone = UserDefaults.standard.string(forKey: "timeZone") ?? ""   //grabs timezone from userdefaults
        dateFormatter.timeZone = TimeZone(identifier: timeZone)                 //timezone modifies dateformatter

        let cal = Calendar(identifier: .gregorian)
       
        let date = Date()
        let hour = cal.component(.hour, from: date)
     
        let locale = TimeZone.init(identifier: timeZone)
        let comparison = cal.dateComponents(in: locale!, from: date)
    
        currentSetTimeZone.text = "Current set timezone is \(timeZone) (\(comparison.hour! - hour))"    //compare timezone to system timezone to get hour offset
        
    }

    func updateTime() {
        digitalClock.text = dateFormatter.string(from: Date())  //This is called every half second by timer
    }
    
    func getCurrentHour() -> Int {

        let timeZone = UserDefaults.standard.string(forKey: "timeZone") ?? ""
        let locale = TimeZone.init(identifier: timeZone)
        let cal = Calendar(identifier: .gregorian)
        let comparison = cal.dateComponents(in: locale!, from: date)
        let hour = comparison.hour
    
        return hour! % 12   //returns timezone modified hour for use with analog clock
        
    }
    
    
}


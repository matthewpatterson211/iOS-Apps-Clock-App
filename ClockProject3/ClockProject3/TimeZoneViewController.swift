//
//  timeZoneViewController.swift
//  ClockProject3
//
//  Created by Matthew Patterson on 11/24/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//

import UIKit



class TimeZoneViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1                                                   //timezonepicker doing picker stuff
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TimeZone.abbreviationDictionary.count                //support our protocol
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
                return timeZones[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.set(timeZones[row], forKey: "timeZone")
    }
    
    

    @IBOutlet weak var timeZonePicker: UIPickerView!
    let timeZones = TimeZone.abbreviationDictionary.reduce(into: [], { (acc, next) in
        acc.append("\(next.value)")
    })
    
    override func viewDidLoad() {
          super.viewDidLoad()
        self.timeZonePicker.delegate = self
        self.timeZonePicker.dataSource = self
      }
}

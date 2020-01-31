//
//  ClockView.swift
//  ClockProject3
//
//  Created by Matthew Patterson on 11/22/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//

import UIKit

class ClockView: UIView {
    
    private let clockLayer = ClockLayer()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.addSublayer(clockLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layer.addSublayer(clockLayer)
    }
    
    override func draw(_ rect: CGRect) {
        clockLayer.frame = rect
    }



}

//
//  ClockLayer.swift
//  ClockProject3
//
//  Created by Matthew Patterson on 11/22/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//

import UIKit

class ClockLayer: CALayer {
    
    @IBOutlet weak var digital: UILabel!

    private let viewController = ViewController()
    
    var hourHand = CALayer()            //declaring layers
    var minuteHand = CALayer()
    var secondHand = CALayer()
    private let circle = CAShapeLayer()
    
    override init() {
        super.init()
        addSublayer(circle)             //adding layers to the view
        addSublayer(hourHand)
        addSublayer(minuteHand)
        addSublayer(secondHand)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers() {
        guard frame != CGRect.zero else { return }
        circle.fillColor = UIColor(red: 0.9, green: 0.95, blue: 0.93, alpha: 0.9).cgColor
        circle.strokeColor = UIColor.gray.cgColor
        let path = CGMutablePath()
        path.addEllipse(in: self.bounds.insetBy(dx: 3, dy: 3))
        circle.path = path

        circle.frame = bounds
        
        drawNumber()
        
        hourHand.bounds = bounds
        hourHand.position = CGPoint(x: bounds.midX, y: bounds.midY)
        hourHand.anchorPoint = CGPoint(x: 0.5, y: 0.35)
        hourHand.contents = drawHourHand()?.cgImage
        
        minuteHand.bounds = bounds
        minuteHand.position = CGPoint(x: bounds.midX, y: bounds.midY)
        minuteHand.anchorPoint = CGPoint(x: 0.5, y: 0.35)
        minuteHand.contents = drawMinuteHand()?.cgImage
        
        secondHand.bounds = bounds
        secondHand.position = CGPoint(x: bounds.midX, y: bounds.midY)
        secondHand.anchorPoint = CGPoint(x: 0.5, y: 0.35)
        secondHand.contents = drawSecondHand()?.cgImage
        
        
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { timer in
            self.updateTime()
            
        })
        
    }
    
    func drawHourHand() -> UIImage? {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        ctx.move(to: CGPoint(x: frame.midX, y: 25))
        ctx.addLine(to: CGPoint(x: frame.midX, y: frame.midY))
        ctx.setLineWidth(10)
        ctx.strokePath()
        
        let arrowImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return arrowImage
    }
    
    func drawMinuteHand() -> UIImage? {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil}
        
        ctx.move(to: CGPoint(x: frame.midX, y: 25))
        ctx.setStrokeColor(UIColor.green.cgColor)
        ctx.addLine(to: CGPoint(x: frame.midX, y: frame.midY))
        ctx.setLineWidth(5)
        ctx.strokePath()
        
        let secondHandImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return secondHandImage
        
    }
    
    func drawSecondHand() -> UIImage? {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil}
        
        ctx.move(to: CGPoint(x: frame.midX, y: 25))
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.addLine(to: CGPoint(x: frame.midX, y: frame.midY))
        ctx.setLineWidth(1)
        ctx.strokePath()
        
        let secondHandImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return secondHandImage
        
    }
    
    func rotateArrowWithTransform(_ transform: CGAffineTransform) {
        CATransaction.setAnimationDuration(1.0)
        hourHand.setAffineTransform(transform)
    }
    
     private func drawNumber() {
//            let timeZones = TimeZone.abbreviationDictionary.reduce(into: [String](), { (acc, next) in
//                acc.append("\(next.key) - \(next.value)")
//            })
            
    //        let myZone = timeZones(identifier)
            
            let twelveLayer = CATextLayer()
            twelveLayer.string = "12"
            twelveLayer.frame = CGRect(x: bounds.midX - 20, y: bounds.minY, width:  40, height: 40)
            twelveLayer.alignmentMode = .center
            twelveLayer.foregroundColor = UIColor.black.cgColor
            circle.addSublayer(twelveLayer)
            
            let threeLayer = CATextLayer()
            threeLayer.string = "3"
            threeLayer.frame = CGRect(x: bounds.maxX - 40, y: bounds.midY - 20, width: 40, height: 40)
            threeLayer.alignmentMode = .center
            threeLayer.foregroundColor = UIColor.black.cgColor
            circle.addSublayer(threeLayer)
            
            let sixLayer = CATextLayer()
            sixLayer.string = "6"
            sixLayer.frame = CGRect(x: bounds.midX - 20, y: bounds.maxY - 40, width: 40, height: 40)
            sixLayer.alignmentMode = .center
            sixLayer.foregroundColor = UIColor.black.cgColor
            circle.addSublayer(sixLayer)
            
            let nineLayer = CATextLayer()
            nineLayer.string = "9"
            nineLayer.frame = CGRect(x: bounds.minX, y: bounds.midY - 20, width: 40, height: 40)
            nineLayer.alignmentMode = .center
            nineLayer.foregroundColor = UIColor.black.cgColor
            circle.addSublayer(nineLayer)
            
        }
    
    func updateTime() {
        
    
        var transform: CGAffineTransform
        
        let timeZone = UserDefaults.standard.string(forKey: "timeZone") ?? ""
        
           
           let date = Date()
        
           let calendar = Calendar(identifier: .gregorian)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        
        
        let hours = viewController.getCurrentHour()

           let minutes = calendar.component(.minute, from: date)
           let seconds = calendar.component(.second, from: date)
        

        let hourAngle = (4.0 / 12.0) * Double(hours) + Double(minutes) * (1.0 / 60.0) * (4.0 / 12.0)
        let minuteAngle = (4.0 / 60.0) * Double(minutes)
        let secondsAngle = (4.0 / 60.0) * Double(seconds)
        
        transform = CGAffineTransform(rotationAngle: CGFloat(Double(hourAngle) * Double.pi) / 2.0)
        
        
        hourHand.setAffineTransform(transform)
        
        transform = CGAffineTransform(rotationAngle: CGFloat(Double(minuteAngle) * Double.pi) / 2.0)
        
        minuteHand.setAffineTransform(transform)
        
        transform = CGAffineTransform(rotationAngle: CGFloat(Double(secondsAngle) * Double.pi) / 2.0)
        
        secondHand.setAffineTransform(transform)
        
        
    
}
    func updateDigital() {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm:ss a"
        let myString = formatter.string(from: Date())
        digital.text = myString
    }
}

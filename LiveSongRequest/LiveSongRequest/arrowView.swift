//
//  arrowView.swift
//  LiveSongRequest
//
//

import UIKit

class arrowView: UIView {

    override func draw(_ rect: CGRect) {
        // Drawing code
        
        if let context = UIGraphicsGetCurrentContext() {
            
            context.setStrokeColor(UIColor.lightGray.cgColor)
            context.setLineWidth(5)
            
            context.move(to: CGPoint(x: 15, y: 15))
            context.addLine(to: CGPoint(x: 5, y: 25))
            context.addLine(to: CGPoint(x: 15, y: 35))
            //context.closePath()
            context.strokePath()
            
        }
    }
}

class arrowViewLeft: UIView {
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        if let context = UIGraphicsGetCurrentContext() {
            
            context.setStrokeColor(UIColor.lightGray.cgColor)
            context.setLineWidth(5)
            
            context.move(to: CGPoint(x: 5, y: 15))
            context.addLine(to: CGPoint(x: 15, y: 25))
            context.addLine(to: CGPoint(x: 5, y: 35))
            //context.closePath()
            context.strokePath()
            
        }
    }
}

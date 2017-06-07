//
//  ConfettiView.swift
//
//  Created by lofo on 06/06/2017.
//  Copyright © 2017 lofo. All rights reserved.
//

import UIKit

public class ConfettiView: UIView {
    
    var confettiArray      :   Array<CALayer>
    var confettiTypes      :   Array<CALayer>
    public var confettiSize       :   CGFloat
    public var confettiDensity    :   CGFloat
    
    override public init(frame: CGRect) {
        
        self.confettiTypes = []
        self.confettiArray = []
        self.confettiSize = 0
        self.confettiDensity = 0
        
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func render()
    {
        var attemptCount, attemptLimit : UInt
        
        /* Clearing layer tree */
        for layer in self.confettiArray {
            layer.removeFromSuperlayer()
        }
        confettiArray.removeAll()
        
        /* Generate and scatter new confettis */
        if confettiTypes.count == 0 { return }
        
        /* declare local utilies functions */
        func randomPosition(rect : CGRect) -> CGPoint {
            var p : CGPoint = rect.origin
            
            p.x = p.x + CGFloat(arc4random_uniform(UInt32(rect.width)))
            p.y = p.y + CGFloat(arc4random_uniform(UInt32(rect.height)))
            
            return p
        }
        
        /* Produces a random angle in [0;2pi]*/
        func randomTilt() -> CGFloat {
            return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * 2 * CGFloat.pi
        }
        
        func distanceBetween(from: CGPoint, to:CGPoint) -> CGFloat {
            return sqrt((from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y))
        }
        
        attemptLimit = 20
        attemptCount = 0
        
        while (attemptCount < attemptLimit)
        {
            // making the frame bigger than the actual frame
            let frame = CGRect(x: self.confettiSize / 2 * -1, y: self.confettiSize / 2 * -1, width: self.frame.size.width + self.confettiSize, height: self.frame.size.height + self.confettiSize)
            let pos = randomPosition(rect: frame)
            
            var isGood = true
            for confettiLayer in self.confettiArray {
                //shouldn't it be .position rather than frame.origin ?
                if distanceBetween(from: confettiLayer.frame.origin, to: pos) < self.confettiDensity
                {
                    attemptCount += 1
                    isGood = false
                    break
                }
            }
            
            if (isGood)
            {
                // make it simple :
                // we pick a confetti type randomly. No sameTypeDensity for the moment.
                let confettiType = Int(arc4random_uniform(UInt32(self.confettiTypes.count)))
                
                // weird copy mecanism. i can maybe do better
                let confettiData = NSKeyedArchiver.archivedData(withRootObject: self.confettiTypes[confettiType])
                let newConfetti = NSKeyedUnarchiver.unarchiveObject(with: confettiData) as! CALayer
                self.confettiArray.append(newConfetti)
                let gridOrigin = self.confettiSize / 2 * -1;
                let confettiFrame = CGRect(x: gridOrigin, y: gridOrigin, width: self.confettiSize, height: self.confettiSize)
                newConfetti.frame = confettiFrame
                self.layer.addSublayer(newConfetti)
                
                let transform = CGAffineTransform.identity.translatedBy(x: pos.x, y: pos.y).rotated(by: randomTilt())
                newConfetti.setAffineTransform(transform)
                
                attemptCount = 0;
            }
        }
    }
    
    public func addConfetti(layer : CALayer)
    {
        self.confettiTypes.append(layer)
    }
    
    //    func removeConfetti(layer : CALayer)
    //    {
    //        self.confettiTypes.remo
    //    }
    
}

/*
 * TODO:
 * replace render by some standard place that would be triggerend whenever
 * the views gets resized and shit
 */

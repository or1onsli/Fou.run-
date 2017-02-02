//
//  backgroundFunc.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//


import Foundation
import UIKit

class SfondoSfumato: UIImageView {

    let redStartSun = 0.93
    let greenStartSun = 0.11
    let blueStartSun = 0.14
    
    let redStartDawn = 0.55
    let greenStartDawn = 0.47
    let blueStartDawn = 1.0
    
    
    let redEndSun = 0.97
    let greenEndSun = 0.93
    let blueEndSun = 0.13
    
    let redEndDawn = 0.99
    let greenEndDawn = 0.49
    let blueEndDawn = 0.48
    
    
    var redStart = 0.8
    var greenStart = 0.3
    var blueStart = 0.5
    
    var redEnd = 0.98
    var greenEnd = 0.6
    var blueEnd = 0.3
    
    
    //Rising true vuol dire che va da Sun a Dawn
    var rising: Bool = true
    var falling: Bool = false
    var risingStart: Bool = true
    var risingEnd: Bool = true
    
    init() {
        super.init(image: nil)
        self.image = drawCustomImage(size: CGSize(width: 375, height: 579))
        self.frame = CGRect(x: 0, y: 0, width: 375, height: 579)
    }
    
    convenience init(size: CGSize) {
        self.init()
        self.image = drawCustomImageCustom(size: size, redStart: CGFloat(redStart), greenStart: CGFloat(greenStart), blueStart: CGFloat(blueStart), redEnd: CGFloat(redEnd), greenEnd: CGFloat(greenEnd), blueEnd: CGFloat(blueEnd))
        
        
    }
    
    func adjustSizeForMain() {
        
        self.image = drawCustomImageCustom(size: (self.superview?.frame.size)!, redStart: CGFloat(redStart), greenStart: CGFloat(greenStart), blueStart: CGFloat(blueStart), redEnd: CGFloat(redEnd), greenEnd: CGFloat(greenEnd), blueEnd: CGFloat(blueEnd))
        
        self.frame = CGRect(x: 0, y: 0, width: (self.superview?.frame.width)!, height: (self.superview?.frame.height)!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func colorAnimate() {
        
        if !risingStart && !risingEnd{
            rising = false
        }
        
        if risingStart && risingEnd {
            rising = true
        }
    
        
        if risingStart {
            if rising {
            if redStart > redStartDawn {
                redStart -= 0.01
            }
            
            if greenStart < greenStartDawn {
                greenStart += 0.01
            }
            
            if blueStart < blueStartDawn {
                blueStart += 0.01
            }
            
            if redStart - redStartDawn < 0.01 && greenStartDawn - greenStart < 0.01 && blueStartDawn - blueStart < 0.01 {
                
                risingStart = false
            }
            }
        } else {
            if !rising {
            if redStart < redStartSun {
                redStart += 0.01
            }
            
            if greenStart > greenStartSun {
                greenStart -= 0.01
            }
            
            if blueStart > blueStartSun {
                blueStart -= 0.01
            }
            
            if redStartSun - redStart < 0.01 && greenStart - greenStartSun<0.01 && blueStart - blueStartSun<0.01 {
                
                risingStart = true
            }
        }
        }
        
        
        if risingEnd {
            if rising {
            if redEnd < redEndDawn {
                redEnd += 0.01
            }
            
            if greenEnd > greenEndDawn {
                greenEnd -= 0.01
            }
            
            if blueEnd < blueEndDawn {
                blueEnd += 0.01
            }
            
            if abs(redEnd - redEndDawn)<0.01 && abs(greenEnd - greenEndDawn)<0.01 && abs(blueEnd - blueEndDawn)<0.01 {

                risingEnd = false
            }
            }
        } else {
            if !rising {
            if redEnd > redEndSun {
                redEnd -= 0.01
            }
            
            if greenEnd < greenEndSun {
                greenEnd += 0.01
            }
            
            if blueEnd > blueEndSun {
                blueEnd -= 0.01
            }
            
            if abs(redEnd - redEndSun)<0.01 && abs(greenEnd - greenEndSun)<0.01 && abs(blueEnd - blueEndSun)<0.01 {
                
                risingEnd = true
            }
        }
        }
        
        
        
        /*
        if redStart < 0.95 && risingStart == true {
            blueStart += 0.01
        } else { risingStart = false }
        
        if greenStart > 0.05 && risingStart == false {
            blueStart -= 0.01
        } else { risingStart = false }
        
        if blueStart < 0.95 && risingStart == true {
            blueStart += 0.01
        } else { risingStart = false }
        
        if redEnd > 0.05 && risingEnd == false {
            blueStart -= 0.01
        } else { risingEnd = true }
        
        if greenEnd < 0.95 && risingEnd == true {
            blueStart += 0.01
        } else { risingEnd = true }
        
        if blueEnd > 0.05 && risingEnd == false {
            blueStart -= 0.01
        } else { risingEnd = true }
        */
        
        self.image = drawCustomImageCustom(size: (self.superview?.frame.size)!, redStart: CGFloat(redStart), greenStart: CGFloat(greenStart), blueStart: CGFloat(blueStart), redEnd: CGFloat(redEnd), greenEnd: CGFloat(greenEnd), blueEnd: CGFloat(blueEnd))
    }
    
}

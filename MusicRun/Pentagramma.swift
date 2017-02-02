//
//  Pentagramma.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import UIKit
import AudioKit

class Pentagramma: UIImageView {
    
    let defaultPosition = CGPoint(x: 0, y: 87)
    let defaultSize = CGSize(width: 750, height: 195)
    var lastBeatAnimationTime: Int = 0
    var nextBeat: Int = 0

    
    init() {
        super.init(image: UIImage(named: "sky_double"))
        self.frame.origin = defaultPosition
        self.frame.size = defaultSize
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func mover() {
        if self.frame.origin.x > defaultPosition.x-375 {
            self.frame.origin.x -= 2} else {
            self.frame.origin.x = defaultPosition.x
        }
    }
    
    func jumper (withCurrentTime currentTime: Double, withArray songArray: [Int]) {
    
        let playerTimeCentsOfSecond = Int((currentTime)*100)
        
        if ((songArray[nextBeat] - playerTimeCentsOfSecond + 140) < 10) && (nextBeat < songArray.count-1) {
            if playerTimeCentsOfSecond - lastBeatAnimationTime > 40 {
                self.frame.size.height = 240
                self.frame.origin.y -= 30
                nextBeat += 1
                lastBeatAnimationTime = playerTimeCentsOfSecond
            } else { nextBeat += 1 }
        } else {
            if self.frame.origin.y < defaultPosition.y {
                self.frame.origin.y += 5}
            if self.frame.size.height > defaultSize.height {
                self.frame.size.height -= 2
            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

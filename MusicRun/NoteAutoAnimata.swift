//
//  noteAutoAnimata.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import Foundation
import UIKit


class NotaAutoAnimata: UIImageView {
    
    var variabilePerSeno: Float = 0
    
    init(startingPosition: CGPoint ) {
        super.init(image:  #imageLiteral(resourceName: "nota_bianca"))
        self.frame.size = CGSize(width: 20, height: 50)
        self.frame.origin = startingPosition
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: {timer in
            
            self.move()
            if self.frame.origin.x <= 0 {
                self.frame.origin = startingPosition
                self.removeFromSuperview()
            }
    })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move() {
        variabilePerSeno += 0.1
        self.frame.origin.x -= 2
        self.frame.origin.y = CGFloat(Float(200) + 50*sin(variabilePerSeno))
    }
    
}

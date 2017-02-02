//
//  BarrierComponent.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class BarrierComponent: GKComponent{
    
    let node: Barriers
    
    init(type: UIImage) {
        node = Barriers(type: type)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

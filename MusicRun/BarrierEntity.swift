//
//  BarrierEntity.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class BarrierEntity: GKEntity{
    
    let type = "barrier"
    
    init(type: UIImage){
        super.init()
        
        let barrier = BarrierComponent(type: type)
        addComponent(barrier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

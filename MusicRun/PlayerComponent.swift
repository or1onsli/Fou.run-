//
//  PlayerEntity.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class PlayerComponent: GKComponent{
    
    let node: Player
    
    init(image: UIImage){
        node = Player(image: image)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

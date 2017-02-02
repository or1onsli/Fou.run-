//
//  PlayerEntity.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class PlayerEntity: GKEntity{
    
    let type = "player"
    
    init(image: UIImage, team: Team){
        super.init()
        
        let player = PlayerComponent(image: image)
        addComponent(player)
        addComponent(TeamComponent(team: team))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

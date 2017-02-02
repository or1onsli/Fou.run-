//
//  NoteEntity.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class NoteEntity: GKEntity{
    
    let type = "note"
    
    init(position: CGPoint){
        super.init()
        
        let note = NoteComponent(position: position)
        addComponent(note)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

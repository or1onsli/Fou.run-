//
//  NoteComponent.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class NoteComponent: GKComponent{
    
    let node: Note
    
    init(position: CGPoint) {
        node = Note(position: position)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  Barriers.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Note: SKSpriteNode {
    
    //MARK: Properties
    
    //MARK: Initializer
    
    init(position: CGPoint){
        
        let text  = SKTexture(image: #imageLiteral(resourceName: "nota_0"))
        super.init(texture: text, color: UIColor.clear, size: text.size())
        createNote(position)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    
    private func createNote(_ position: CGPoint){
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.xScale = 0.05
        self.yScale = 0.05
        
        self.position = position
        self.zPosition = 5
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
        
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Character
        self.physicsBody?.categoryBitMask = PhysicsCategory.Note
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
    }
    
    
}

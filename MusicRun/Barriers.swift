//
//  Barriers.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//
import Foundation
import UIKit
import SpriteKit

class Barriers: SKSpriteNode {
    
    //MARK: Properties
    
    //MARK: Initializer
    
    init(type: UIImage){
        
        let text  = SKTexture(image: type)
        super.init(texture: text, color: UIColor.clear, size: text.size())
        createBarrier()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Functions
    
    private func createBarrier(){
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.zPosition = 5
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.HighBarrier
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Character
        self.physicsBody?.collisionBitMask = PhysicsCategory.None
        self.physicsBody?.usesPreciseCollisionDetection = true
        
    }
}

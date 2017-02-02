//
//  Player.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Player: SKSpriteNode {
    
    let SCENE_EDGE_CATEGORY: UInt32 = 0x1
    
    //MARK: player texture properties
    
    let runAnimation: [SKTexture] = [SKTexture(imageNamed: "player_0"),
                                     SKTexture(imageNamed: "player_1"),
                                     SKTexture(imageNamed: "player_2")]
    
    let deathAnimation: [SKTexture] = [SKTexture(imageNamed: "player_0"),
                                    SKTexture(imageNamed: "death_0"),
                                    SKTexture(imageNamed: "player_1"),
                                    SKTexture(imageNamed: "death_1"),
                                    SKTexture(imageNamed: "player_2"),
                                    SKTexture(imageNamed: "death_2")]
    
    let jumpAnimation: [SKTexture] = [SKTexture(imageNamed: "jumping_1"),
                                        SKTexture(imageNamed: "jumping_2"),
                                        SKTexture(imageNamed: "jumping_3"),
                                        SKTexture(imageNamed: "jumping_3"),
                                        SKTexture(imageNamed: "jumping_3"),
                                        SKTexture(imageNamed: "jumping_4"),
                                        SKTexture(imageNamed: "jumping_4")]
    
    let swipeAnimation: [SKTexture] = [SKTexture(imageNamed: "swipe_down"),
                                    SKTexture(imageNamed: "swipe_down"),
                                    SKTexture(imageNamed: "swipe_down")]
    
    
    //MARK: initializers
    init(image: UIImage){
        let texture = SKTexture(image: image)
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        setPlayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setPlayer(){
        
        self.xScale = 0.45
        self.yScale = 0.45
        self.anchorPoint.x = 0.5
        self.anchorPoint.y = 0.5
        let x = CGPath(ellipseIn: CGRect.init(x: -32, y: -32, width: self.frame.size.width - 10, height: self.frame.size.height - 10) , transform: nil)
        self.physicsBody = SKPhysicsBody(polygonFrom: x)
        
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Note
        self.physicsBody?.categoryBitMask = PhysicsCategory.Character
        
        self.physicsBody?.collisionBitMask = SCENE_EDGE_CATEGORY
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.run(SKAction.repeatForever(SKAction.animate(with: self.runAnimation, timePerFrame: 0.05)))
        
    }
    
    func jump(){
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 10)
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 125))
        self.run(SKAction.animate(with: jumpAnimation, timePerFrame: 0.05))
    }
    
    func swipe(){
        
        let x = CGPath(ellipseIn: CGRect.init(x: -32, y: -32, width: self.frame.size.width - 10, height: self.frame.size.height/2) , transform: nil)
        self.physicsBody = SKPhysicsBody(polygonFrom: x)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.restitution = 0
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Note
        self.physicsBody?.categoryBitMask = PhysicsCategory.Character
        self.physicsBody?.collisionBitMask = SCENE_EDGE_CATEGORY
        self.physicsBody?.usesPreciseCollisionDetection = true
        
        self.run(SKAction.animate(with: swipeAnimation, timePerFrame: 0.13), completion: {() -> Void in
            let x = CGPath(ellipseIn: CGRect.init(x: -32, y: -32, width: self.frame.size.width - 10, height: self.frame.size.height - 10) , transform: nil)
            self.physicsBody = SKPhysicsBody(polygonFrom: x)
            self.physicsBody?.isDynamic = true
            self.physicsBody?.allowsRotation = false
            self.physicsBody?.restitution = 0
            self.physicsBody?.contactTestBitMask = PhysicsCategory.Note
            self.physicsBody?.categoryBitMask = PhysicsCategory.Character
            self.physicsBody?.collisionBitMask = self.SCENE_EDGE_CATEGORY
            self.physicsBody?.usesPreciseCollisionDetection = true
            
        })
    }
    
}

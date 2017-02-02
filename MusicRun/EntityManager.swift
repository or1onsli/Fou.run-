//
//  EntityManager.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class EntityManager {
    
    //MARK: Properties
    var entities = Set<GKEntity>()
    let scene: SKScene
    
    //MARK: Initializer
    init(scene: SKScene){
        self.scene = scene
    }
    
    //MARK: Add-Remove Functions
    func add(entity: GKEntity){
        entities.insert(entity)
        
        if let playerNode = entity.component(ofType: PlayerComponent.self)?.node{
            scene.addChild(playerNode)
        }
        
        if let barrierNode = entity.component(ofType: BarrierComponent.self)?.node{
            scene.addChild(barrierNode)
            
            let moveBarrier = SKAction.move(to: CGPoint(x: -barrierNode.size.width/2, y: barrierNode.position.y), duration: 1.5)
            barrierNode.run(SKAction.sequence([moveBarrier, SKAction.run {
                self.remove(entity: entity)
                }]))
            
        }
        
        if let noteNode = entity.component(ofType: NoteComponent.self)?.node{
            scene.addChild(noteNode)
            
            let moveNote = SKAction.move(to: CGPoint(x: -noteNode.size.width/2, y: noteNode.position.y), duration: 1.18)
            //let moveNoteDone = SKAction.removeFromParent()
            noteNode.run(SKAction.sequence([moveNote, SKAction.run {
                self.remove(entity: entity)
                }]))
        }
    }
    
    func remove(entity: GKEntity){
        if let playerNode = entity.component(ofType: PlayerComponent.self)?.node{
            playerNode.removeFromParent()
        }
        
        if let barrierNode = entity.component(ofType: BarrierComponent.self)?.node{
            barrierNode.removeFromParent()
        }
        
        if let noteNode = entity.component(ofType: NoteComponent.self)?.node{
            noteNode.removeFromParent()
        }
        
        entities.remove(entity)
    }
    
    func getEntity(type: String) -> GKEntity?{
        
        if type == "player"{
            for entity in entities{
                if let tmp = entity as? PlayerEntity{
                    return tmp
                }
            }
        }
        else if type == "barrier"{
            for entity in entities{
                if let tmp = entity as? BarrierEntity{
                    return tmp
                }
            }
        }
        else if type == "note"{
            for entity in entities{
                if let tmp = entity as? NoteEntity{
                    return tmp
                }
            }
        }
        
        return nil
    }
    
    //MARK: Create Functions
    func spawnBarriers(type: UIImage, team: Team){
        
        let barrier = BarrierEntity(type: type)
        
        if let barrierComponent = barrier.component(ofType: BarrierComponent.self){
            barrierComponent.node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            if let scene = self.scene as? GameScene{
                if type == BarrierTexture.high {
                    barrierComponent.node.position = CGPoint(x: (scene.view?.frame.width)! + barrierComponent.node.frame.size.width/2, y: scene.lowerBar.size.height + 40)
                    barrierComponent.node.zPosition = 5
                    barrierComponent.node.xScale = 0.6
                    barrierComponent.node.yScale = 0.6
                    print("OK")
                }
                else if type == BarrierTexture.low{
                    barrierComponent.node.position = CGPoint(x: (scene.view?.frame.width)! + barrierComponent.node.frame.size.width/2, y: scene.lowerBar.size.height + 20)
                    barrierComponent.node.xScale = 0.5
                    barrierComponent.node.yScale = 0.7
                    barrierComponent.node.zPosition = 5
                }
                else if type == BarrierTexture.medium{
                    barrierComponent.node.position = CGPoint(x: scene.frame.size.width + barrierComponent.node.size.width/2, y: scene.lowerBar.frame.size.height + 85)
                    barrierComponent.node.xScale = 0.35
                    barrierComponent.node.yScale = 0.35
                    barrierComponent.node.zPosition = 5
                    print("NOPE")
                }

            }
        }
        add(entity: barrier)
    }
    
    
    func spawnNotes(position: CGPoint){
        let note = NoteEntity(position: position)
        
        if let noteComponent = note.component(ofType: BarrierComponent.self){
            noteComponent.node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        }
        add(entity: note)
        
    }
}

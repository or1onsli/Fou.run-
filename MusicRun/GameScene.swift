//
//  GameScene.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import SpriteKit
import AudioKit

class GameScene: SKScene, SKPhysicsContactDelegate, UIGestureRecognizerDelegate {

    //MARK: Properties
    var textLabel: UILabel = UILabel()
    let lowerBar = SKSpriteNode(imageNamed: "lowerBar-1")
    var barriers: Array<SKSpriteNode> = []
    var entityManager: EntityManager!
    var punteggio: Int = 0
    
    //MARK: ToDo
    var bpm = 1.78
    var noteSpeed = 1.9
    var barriersNumber = 5
    var barrierType = "barrier"
    var barrierCount: Int = 0
    
    //MARK: Proprietà ex-GameViewController
    var nextObstacle: Int = 2
    var lastCreationTime: Int = 0
    
    override func didMove(to view: SKView) {
        
        entityManager = EntityManager(scene: self)
        self.backgroundColor = .clear
        initLowerBar()
        
        let player = PlayerEntity(image: #imageLiteral(resourceName: "player_0"), team: .PlayerTeam)
        if let playerComponent = player.component(ofType: PlayerComponent.self){
            playerComponent.node.position = CGPoint(x: self.size.width / 6, y: lowerBar.size.height + 90)
            playerComponent.node.zPosition = 5
        }
        entityManager.add(entity: player)
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -27)
        
        barrierCount = songArray.count
        
        
    }
    
    override func didSimulatePhysics() {
//        if player.physicsBody?.velocity.dy == 0 {
//            jumpCount = 0
//        }
    }
    
    //MARK: Setters
    
    func initLowerBar(){
        lowerBar.yScale = 0.5
        lowerBar.size.height = 95
        lowerBar.position = CGPoint(x: (self.view?.center.x)!, y: 50)
        lowerBar.zPosition = 5
    }
    
    
    func setTextPointsLabel() -> UILabel{
        
        textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        textLabel.center = CGPoint(x: 68, y: 30)
        textLabel.font = UIFont(name: "Galindo-Regular", size: 25)
        textLabel.textAlignment = .center
        textLabel.text = "0"
        
        return textLabel
    }
    
    
    //MARK: Collisions
    
    func collideWithHighBarrier(character: SKSpriteNode, barrier: SKSpriteNode){
        print("ora muore")
        
        punteggio -= 7

        //barrier.removeFromParent()
        barrier.isHidden = true
        if let player = entityManager.getEntity(type: "player"){
            player.component(ofType: PlayerComponent.self)?.node.run(SKAction.animate(with: (player.component(ofType: PlayerComponent.self)?.node.deathAnimation)!, timePerFrame: 0.08))
        }
        
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
    }
    
    func collideWithLowBarrier(character: SKSpriteNode, barrier: SKSpriteNode){
        print("ora muore")
        
        punteggio -= 4
//        if let entity = entityManager.getEntity(type: "barrier"){
//            entityManager.remove(entity: entity)
//        }
        barrier.isHidden = true
        
//        barrier.removeFromParent()
        
        if let player = entityManager.getEntity(type: "player"){
            player.component(ofType: PlayerComponent.self)?.node.run(SKAction.animate(with: (player.component(ofType: PlayerComponent.self)?.node.deathAnimation)!, timePerFrame: 0.08))
        }
        
        if var points: Int = Int(textLabel.text!){
            points -= 1
            textLabel.text = "\(points)"
        }
        
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
    }
    
    func takeTheNote(character: SKSpriteNode, note: SKSpriteNode){
        print("Prendo la nota")
        punteggio += 1
        note.isHidden = true
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.Character) != 0 && (secondBody.categoryBitMask & PhysicsCategory.HighBarrier) != 0){
            print("collide con alta")
            collideWithHighBarrier(character: firstBody.node as! SKSpriteNode, barrier: secondBody.node as! SKSpriteNode)
        }
        else if ((firstBody.categoryBitMask & PhysicsCategory.Character) != 0 && (secondBody.categoryBitMask & PhysicsCategory.LowBarrier) != 0){
            print("collide con bassa")
            collideWithLowBarrier(character: firstBody.node as! SKSpriteNode, barrier: secondBody.node as! SKSpriteNode)
        }
        else if ((firstBody.categoryBitMask & PhysicsCategory.Character) != 0 && (secondBody.categoryBitMask & PhysicsCategory.Note) != 0){
            takeTheNote(character: firstBody.node as! SKSpriteNode, note: secondBody.node as! SKSpriteNode)
        }
      
        
    }
    
    //MARK: Obstacles and notes
    
    func setNote(note: Note){
        self.addChild(note)
        
        let moveNote = SKAction.move(to: CGPoint(x: -note.size.width/2, y: note.position.y), duration: noteSpeed)
        let moveNoteDone = SKAction.removeFromParent()
        note.run(SKAction.sequence([moveNote, moveNoteDone]))
    }
    
    func obstacleGenerator(withCurrentTime currentTime: Double, withArray songArray: [Int], withLevelDesign levelDesign: [Int]) {
        
        let playerTimeCentsOfSecond = Int((currentTime)*100) + 140
        
        if (songArray[nextObstacle] > playerTimeCentsOfSecond) && (nextObstacle < songArray.count){
            if songArray[nextObstacle] - playerTimeCentsOfSecond < 5 {
                if playerTimeCentsOfSecond - lastCreationTime > 0 {
                    nextObstacle += 1
                    
                    if levelDesign[nextObstacle]  == 2 {
                        
                        entityManager.spawnBarriers(type: BarrierTexture.high, team: Team.BarrierTeam)
                        
                    }
                    else if levelDesign[nextObstacle] == 3 {
                        
                        entityManager.spawnBarriers(type: BarrierTexture.low, team: Team.BarrierTeam)
                        
                    } else if levelDesign[nextObstacle] == 1 {
                        
                        entityManager.spawnBarriers(type: BarrierTexture.medium, team: Team.BarrierTeam)
                        
                    } else {

                    }
                    lastCreationTime = playerTimeCentsOfSecond
                } else {
                    print("ho skippato un beat")
                }
                
                entityManager.spawnNotes(position: CGPoint(x: ( scene?.size.width)!, y: (self.lowerBar.size.height) * 1.2 + CGFloat(arc4random_uniform(10) * 10 ) ))
            }
        } else {
            nextObstacle += 1
        }
    }

    
}

//
//  GameViewController.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import SpriteKit
import GameplayKit
import AudioKit
import UIKit

//MARK:Testing mediaPlayer
import MediaPlayer

class GameViewController: UIViewController, SKSceneDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var buttone: UIButton!
    @IBOutlet weak var punteggioLabel: UILabel!
    @IBOutlet weak var notaPunteggio: UIImageView!
    
    
    //MARK: GestureRecognizers
    var swipeRightGesture: UISwipeGestureRecognizer?
    var tapGesture: UITapGestureRecognizer?
    
    //MARK: PROPERTIES
    var scene: GameScene!
    var currentGameTime: Double = 0.00
    var nextBarrier: Int = 0
    var nextNote: Int = 0
    var sfondo: SfondoSfumato!
    var pentagramma: Pentagramma!
    var musicPlayer: AKAudioPlayer?
    var lastNoteCreationTime: Int = 0
    var textLabel = UILabel()
    var presenterView: SKView!
    var songUrl: URL = URL(string: "fakeString")!
    var songArray: Array<Int> = []
    var song = ""
    var levelDesign: Array<Int> = []
    var index = 0
    var isEnded = true
    
    //MARK: VIEW CONTROLLER DELEGATE
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: import song from mediaPlayer library
        levelDesign = levelGenerator(fromArray: songArray)
        // Istanziamo il player della canzone
        do{
            let fileS = try AKAudioFile(readFileName: self.song)
            musicPlayer = try AKAudioPlayer(file: fileS)
            musicPlayer?.looping = false
            musicPlayer?.completionHandler = {() -> Void in
            var alert = UIAlertController()
            var action = UIAlertAction()
                if self.isEnded{
                    alert = UIAlertController(title: "Great!", message: "You have scored \(self.scene.punteggio) points!", preferredStyle: .alert)
                    action = UIAlertAction(title: "Ok", style: .default, handler: {(action) -> Void in
                        self.performSegue(withIdentifier: "songEnded", sender: self)
                    })
                    alert.addAction(action)
                    DispatchQueue.main.async {
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    }}
                
                
            }
        } catch { print("errore") }
        
        
        presenterView = SKView(frame: self.view.frame)

        
        sfondo = SfondoSfumato()
        pentagramma = Pentagramma()

        self.view.addSubview(sfondo)
        self.view.addSubview(pentagramma)
        
        // Qui il plotter, gli argomenti sono abbastanza autoesplicativi
        wavePlotter(viewController: self, musicPlayer: musicPlayer!)
        
        sceneInit()
        self.view.bringSubview(toFront: buttone)
        self.view.bringSubview(toFront: punteggioLabel)
        self.view.bringSubview(toFront: notaPunteggio)
        
        AudioKit.output = musicPlayer
        AudioKit.start()
        musicPlayer?.play()
        
        swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(sender:)))
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(sender:)))
        
        let gestureView = UIView(frame: CGRect(x: 0, y: (self.view.frame.size.height*5)/6, width: self.view.frame.size.width, height: self.view.frame.size.height/6))
        gestureView.backgroundColor = .clear
        gestureView.addGestureRecognizer(tapGesture!)
        gestureView.addGestureRecognizer(swipeRightGesture!)
        self.view.addSubview(gestureView)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let gestures = self.view.subviews.last{
            if let recognizer = gestures.gestureRecognizers {
                gestures.removeGestureRecognizer(recognizer[0])
                gestures.removeGestureRecognizer(recognizer[1])
            }
        }
        AudioKit.stop()
        musicPlayer = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
//        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false
    }
    
    func update(_ currentTime: TimeInterval, for scene: SKScene) {
       
        let giocoScene = scene as! GameScene
        punteggioLabel?.text = String(giocoScene.punteggio)
        if let playerCurrentTime = (self.musicPlayer?.currentTime){
            giocoScene.obstacleGenerator(withCurrentTime: playerCurrentTime, withArray: benny, withLevelDesign: levelDesign)
            
            sfondo.colorAnimate()
            
            pentagramma.jumper(withCurrentTime: playerCurrentTime, withArray: songArray)
            pentagramma.mover()
        }
    }
    
    
    @IBAction func debug() {
        self.isEnded = false
        self.performSegue(withIdentifier: "songEnded", sender: self)
    }
    
    private func sceneInit(){
        
        let gameRect = CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: self.view.bounds.size.height-150)
        
        scene = GameScene(size: gameRect.size)
        scene?.delegate = self
        scene?.physicsBody = SKPhysicsBody(edgeLoopFrom: gameRect)
        scene?.physicsBody?.categoryBitMask = 0x1
        scene?.physicsBody?.contactTestBitMask = PhysicsCategory.Character
        //        viewController.scene?.physicsBody?.collisionBitMask = physicsCategory.None
        scene?.physicsBody?.restitution = 0
        scene?.physicsBody?.isDynamic = false
        scene?.physicsBody?.affectedByGravity = false

        view.addSubview(presenterView)
        presenterView.showsFPS = false
        presenterView.showsPhysics = false
        presenterView.showsNodeCount = false
        presenterView.ignoresSiblingOrder = true
        presenterView.allowsTransparency = true
        scene?.scaleMode = .resizeFill
        presenterView.presentScene(scene)
        view.bringSubview(toFront: presenterView)

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    //MARK: Gestures
    
    func swipeGesture(sender:UISwipeGestureRecognizer){
        if let player = self.scene.entityManager.getEntity(type: "player") as? PlayerEntity{
            player.component(ofType: PlayerComponent.self)?.node.swipe()
        }
    }
    
    func tapGesture(sender: UITapGestureRecognizer){
        if let player = self.scene.entityManager.getEntity(type: "player") as? PlayerEntity{
            player.component(ofType: PlayerComponent.self)?.node.jump()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destVC = segue.destination as? PlaylistTableViewController{
//            destVC.songs[index].score = self.scene.punteggio
//        }
    }
}


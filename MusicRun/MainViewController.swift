//
//  MainViewController.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var immagineGiocatore: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    //MARK: OUTLETS
    
    //MARK: PROPERTIES
    var cloud = false
    var sfondo: SfondoSfumato!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sfondo = SfondoSfumato()
        view.addSubview(sfondo)
        sfondo.adjustSizeForMain()
        view.sendSubview(toBack: sfondo)
        
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: {
            _ in
            self.sfondo.colorAnimate()
        } )
        Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true, block:
            {_ in
                let newNota = NotaAutoAnimata(startingPosition: CGPoint(x: self.view.frame.size.width, y: 200))
                
                self.view.insertSubview(newNota, belowSubview: self.immagineGiocatore)
                
        }
        )
        

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setPlayerPortrait(image: immagineGiocatore)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    @IBAction func localMusicButton(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "toTableView", sender: self)
    }
    
    //MARK: ImageView Player
    
    func setPlayerPortrait(image: UIImageView){
        image.layer.borderWidth=1.5
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.cornerRadius = image.frame.size.height/2
        image.clipsToBounds = true
    }
    
    override var prefersStatusBarHidden: Bool{
        
        return true
    }
}

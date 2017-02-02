//
//  wavePlotter.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import Foundation
import AudioKit

func wavePlotter(viewController: GameViewController, musicPlayer player: AKAudioPlayer) {
    
    var secondPlot: AKNodeOutputPlot!

    let plotRect = CGRect(x: 0, y: 0, width: 64, height: 8)
    secondPlot = AKNodeOutputPlot.init(player, frame: plotRect)
    secondPlot.color = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    secondPlot.backgroundColor = .black
    secondPlot.transform = CGAffineTransform(scaleX: 10, y: 13)
    
    secondPlot.center = CGPoint(x: 300, y: 615)
    
    viewController.view.addSubview(secondPlot)
    viewController.view.bringSubview(toFront: secondPlot)

}

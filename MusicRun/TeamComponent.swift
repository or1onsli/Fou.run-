//
//  TeamComponent.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

enum Team: Int{
    case PlayerTeam = 1
    case BarrierTeam = 2
    case NoteTeam = 3
    
    static let allValues = [PlayerTeam, BarrierTeam, NoteTeam]
    
    func oppositeTeam() -> Team{
        switch self{
            case .PlayerTeam:
                return .BarrierTeam
            case .BarrierTeam:
                return .PlayerTeam
            default:
                return .NoteTeam
        }
    }
}

class TeamComponent: GKComponent{
    
    let team: Team
    
    init(team: Team){
        self.team = team
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

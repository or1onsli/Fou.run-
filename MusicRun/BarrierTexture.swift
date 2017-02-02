//
//  BarrierTexture.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import Foundation
import UIKit

struct BarrierTexture {
    static let high: UIImage = #imageLiteral(resourceName: "ostacolo_alto_1")
    static let low: UIImage = #imageLiteral(resourceName: "ostacolo_basso_1")
    static let medium: UIImage = #imageLiteral(resourceName: "ostacolo_medio")
    
    static let highBarrierAnimation: [UIImage] = [#imageLiteral(resourceName: "ostacolo_alto_1"),
                                           #imageLiteral(resourceName: "ostacolo_alto_2"),
                                           #imageLiteral(resourceName: "ostacolo_alto_3")]
    static let lowBarrierAnimation: [UIImage] = [#imageLiteral(resourceName: "ostacolo_basso_1"),
                                          #imageLiteral(resourceName: "ostacolo_basso_2"),
                                          #imageLiteral(resourceName: "ostacolo_basso_3")]
}

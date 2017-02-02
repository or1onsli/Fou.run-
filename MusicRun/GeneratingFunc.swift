//
//  File.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import Foundation
import UIKit

func levelGenerator(fromArray songArray: [Int])->[Int] {
    
    var arrayOfDifferences: [Int] = []
    var arrayOfDesign: [Int] = []
    var somma: Int = 0
    
    for index in songArray.indices {
        if index < songArray.indices.max()! - 1 {
            let difference = songArray[index+1]-songArray[index]
            arrayOfDifferences.append(difference)
            somma+=difference
        }
    }
    
    let media = somma/arrayOfDifferences.count
    
    for value in arrayOfDifferences {
        if value >= media-1 && value <= media+10 {
            arrayOfDesign.append(2)
        } else if value > media + 10 {
            arrayOfDesign.append(3)
        } else {
            arrayOfDesign.append(1)
        }
    }
    print(arrayOfDesign)
    /*
    for index in arrayOfDesign.indices {
        if index < arrayOfDesign.indices.max()! {
            if (arrayOfDesign[index] == 1 || arrayOfDesign[index] == 2) && (arrayOfDesign[index+1] == 1 || arrayOfDesign[index+1] == 2) {
                arrayOfDesign[index+1] = 0
            }
            
            if arrayOfDesign[index] == 2 && arrayOfDesign[index+1] == 2 {
                arrayOfDesign[index+1] = 0
            }
        }
    }*/
    var buuuuuleano: Bool = false
    for index in arrayOfDesign.indices {
        if buuuuuleano {
            arrayOfDesign[index] = 0
        }
        buuuuuleano = !buuuuuleano
    }
    print(arrayOfDesign)
    
    return arrayOfDesign
}

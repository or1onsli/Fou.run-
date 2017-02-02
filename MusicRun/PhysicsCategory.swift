//
//  PhysicsCategory.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

struct PhysicsCategory {
    static let None       : UInt32 = 0
    static let All        : UInt32 = UInt32.max
    static let Character  : UInt32 = 0b0001
    static let HighBarrier: UInt32 = 0b0010
    static let LowBarrier : UInt32 = 0b0100
    static let Note       : UInt32 = 0b1000
}

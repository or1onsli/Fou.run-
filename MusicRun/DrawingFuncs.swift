//
//  drawingFuncs.swift
//  Fou.run()
//
//  Copyright © 2016 Shock&Awe. All rights reserved.
//

import Foundation
import UIKit


func drawCustomImageCustom(size: CGSize, redStart: CGFloat, greenStart: CGFloat, blueStart: CGFloat, redEnd: CGFloat, greenEnd: CGFloat, blueEnd: CGFloat) -> UIImage {
    
    // Setup our context
    let bounds = CGRect(origin: CGPoint.zero, size: size)
    let opaque = false
    let scale: CGFloat = 0
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
    let context = UIGraphicsGetCurrentContext()
    
    // Setup complete, do drawing here
    
    let color1: [CGFloat] = [ redStart, greenStart, blueStart, 1.0]
    let color2: [CGFloat] = [ redEnd, greenEnd, blueEnd, 1.0]
    
    let colors = [ CGColor.init(colorSpace: CGColorSpaceCreateDeviceRGB(), components: color1), CGColor.init(colorSpace: CGColorSpaceCreateDeviceRGB(), components: color2)]
    let locations: [CGFloat] = [0.0, 1.0]
    
    let startPoint = CGPoint(x: bounds.maxX, y: bounds.maxY)
    
    let endPoint = CGPoint(x: bounds.minX, y: bounds.minY)
    let gradient = CGGradient(colorsSpace: nil , colors: colors as CFArray, locations: locations )
    
    context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: .drawsAfterEndLocation)
    
    // Drawing complete, retrieve the finished image and cleanup
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
    
}


func drawCustomImage(size: CGSize) -> UIImage {
    
    // Setup our context
    let bounds = CGRect(origin: CGPoint.zero, size: size)
    let opaque = false
    let scale: CGFloat = 0
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
    let context = UIGraphicsGetCurrentContext()
    
    // Setup complete, do drawing here
    let color1: [CGFloat] = [ 0.93, 0.11, 0.14, 1.0]
    let color2: [CGFloat] = [ 0.98, 0.93, 0.13, 1.0]
    
    let colors = [ CGColor.init(colorSpace: CGColorSpaceCreateDeviceRGB(), components: color1), CGColor.init(colorSpace: CGColorSpaceCreateDeviceRGB(), components: color2)]
    let locations: [CGFloat] = [0.0, 1.0]
    
    let startPoint = CGPoint(x: bounds.maxX, y: bounds.maxY)
    
    let endPoint = CGPoint(x: bounds.minX, y: bounds.minY)
    
    let gradient = CGGradient(colorsSpace: nil , colors: colors as CFArray, locations: locations )
    
    context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: .drawsAfterEndLocation)
    
    // Drawing complete, retrieve the finished image and cleanup
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}

//
//  Person.swift
//  Austin Murals
//
//  Created by Brandon Mahoney on 7/24/19.
//  Copyright © 2019 Brandon Mahoney. All rights reserved.
//

import Foundation
import UIKit
import SceneKit


class Person {
    
    var node: SCNNode?
    var distanceToCenter: CGFloat = 0
    
    
    init(node: SCNNode, renderer: SCNSceneRenderer, centerLocation: CGPoint) {
        self.node = node
        self.distanceToCenter = getDistance(for: node, in: renderer, from: centerLocation)
    }
    
    //Get distance from node to center point of screen
    func getDistance(for node: SCNNode, in renderer: SCNSceneRenderer, from location: CGPoint) -> CGFloat {
        let nodePosition = node.convertPosition(SCNVector3Zero, to: nil)
        let projectedPoint = renderer.projectPoint(nodePosition)
        let projectedCGPoint = CGPoint(x: CGFloat(projectedPoint.x), y: CGFloat(projectedPoint.y))
        let distance = projectedCGPoint.distance(to: location)
        
        return distance
    }
    
}




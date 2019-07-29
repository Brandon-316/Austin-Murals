//
//  Extension.swift
//  Austin Murals
//
//  Created by Brandon Mahoney on 7/24/19.
//  Copyright © 2019 Brandon Mahoney. All rights reserved.
//

import Foundation
import UIKit



public extension CGPoint {
    ///Gives bearing between 2 vectors
    func heading(to point: CGPoint) -> CGFloat {
        let heading = atan2(point.x - self.x, point.y - self.y)
        
        return heading
    }
    
    ///Gives destination point, given a heading and distance
    func destination(heading: CGFloat, distance: CGFloat) -> CGPoint {
        let x = distance * sin(heading)
        let y = distance * cos(heading)
        
        return CGPoint(x: self.x + x, y: self.y + y)
    }
    
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(self.x - point.x, 2) + pow(self.y - point.y, 2))
    }
}

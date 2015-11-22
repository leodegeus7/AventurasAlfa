//
//  File.swift
//  Rock Box
//
//  Created by Leonardo Geus on 11/06/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

import UIKit
import SpriteKit

class StarNode: SKSpriteNode {
    class func star(location: CGPoint) -> StarNode {
        let sprite = StarNode(imageNamed:"star.png")
        
        sprite.xScale = 0.075
        sprite.yScale = 0.075
        sprite.position = location
        
        if #available(iOS 8.0, *) {
            sprite.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "star.png"), alphaThreshold: 1, size: sprite.size)
        } else {
        }
        if let physics = sprite.physicsBody {
            physics.affectedByGravity = true
            physics.allowsRotation = true
            physics.dynamic = true;
            physics.linearDamping = 0.75
            physics.angularDamping = 0.75
        }
        return sprite
    }
}
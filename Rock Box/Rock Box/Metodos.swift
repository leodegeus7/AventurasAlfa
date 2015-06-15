//
//  Metodos.swift
//  Rock Box
//
//  Created by Leonardo Geus on 12/06/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

import UIKit
import SpriteKit

class Metodos: NSObject {
   
    class func criarPlanetas(cena: GameScene, posicao: CGPoint, raio:CGFloat, habilitarRegiao:Bool, raioAtmosfera:Float, falloff:Float, strenght:Float, imagem: String) -> SKSpriteNode {
        var fieldNode = SKFieldNode.radialGravityField()
        fieldNode.falloff = falloff
        fieldNode.strength = strenght;
        fieldNode.animationSpeed = 0.5
        if (habilitarRegiao){
            fieldNode.region = SKRegion(radius: Float(raio) + raioAtmosfera)
        }
        fieldNode.position = posicao
        fieldNode.enabled = true
        fieldNode.physicsBody = SKPhysicsBody(circleOfRadius: raio)
        fieldNode.physicsBody?.dynamic = false
        let fieldCategory: UInt32 = 0x1 << 1
        fieldNode.categoryBitMask = fieldCategory
        
        fieldNode.physicsBody?.allowsRotation = true
        fieldNode.physicsBody?.applyAngularImpulse(100)
        var imageFieldNode = SKSpriteNode(imageNamed: imagem)
        imageFieldNode.size = CGSizeMake(raio*2, raio*2)
        imageFieldNode.physicsBody = SKPhysicsBody(circleOfRadius: raio)
        imageFieldNode.physicsBody?.dynamic = true
        imageFieldNode.position = CGPoint(x: 0, y: 0)
        imageFieldNode.physicsBody?.collisionBitMask = 0x0
        imageFieldNode.physicsBody?.contactTestBitMask = 0x0
        imageFieldNode.physicsBody?.fieldBitMask = 0x0
        imageFieldNode.physicsBody?.affectedByGravity = false
        imageFieldNode.physicsBody?.applyAngularImpulse(100)
        fieldNode.addChild(imageFieldNode)
        cena.addChild(fieldNode)
        return imageFieldNode
        
    }
    
}

//
//  GameScene.swift
//  Rock Box
//
//  Created by Leonardo Geus on 11/06/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    
    var labelAngulo:SKLabelNode!
    var teste:SKSpriteNode!
    var teste2 = SKSpriteNode()
    var player = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        self.physicsWorld.contactDelegate = self
        
        teste = self.criarPlanetasComPosicao(CGPointMake(self.frame.width / 2, self.frame.height / 3), raio: 20, habilitarRegiao:true,raioAtmosfera:100, falloff: 1, strenght: 1, imagem: "4.png")
        
        //Metodos.criarPlanetas(self, posicao: CGPointMake(self.frame.width / 2, self.frame.height), raio: 100,habilitarRegiao:false, raioAtmosfera:40, falloff: 1, strenght: 1, imagem: "2.png")
        //Metodos.criarPlanetas(self, posicao: CGPointMake(self.frame.width / 2, 0), raio: 100,habilitarRegiao:true,  raioAtmosfera:40 ,falloff: 1, strenght: 1, imagem: "3.png")
        
        teste2 = self.criarPlanetasComPosicao(CGPointMake(self.frame.width / 3 , 2/3 * self.frame.height), raio: 100, habilitarRegiao:true,raioAtmosfera:10000, falloff: 1, strenght: 2, imagem: "4.png")
        
        
        let spriteTeste = SKSpriteNode(imageNamed: "5.png")
        spriteTeste.size = CGSize(width: 299/10, height: 703/10)
        spriteTeste.position = CGPointMake(self.frame.width / 2, teste.parent!.position.y + teste.frame.size.height/2 + 40)
        spriteTeste.name = "personagens"
        spriteTeste.physicsBody?.allowsRotation = false
        spriteTeste.physicsBody = SKPhysicsBody(rectangleOfSize: spriteTeste.size)
        spriteTeste.physicsBody?.affectedByGravity = true
        spriteTeste.physicsBody?.dynamic = false
        spriteTeste.physicsBody?.mass = 100
        spriteTeste.physicsBody?.velocity = CGVector(dx: -100, dy: -20)
        //spriteTeste.physicsBody?.applyForce(CGVector(dx: 10000, dy: 0))
        //spriteTeste.physicsBody?.applyImpulse(CGVector(dx: -100000, dy: 0))
        player = spriteTeste
        
        addChild(player)
        
        labelAngulo = SKLabelNode(fontNamed: "Arial")
        labelAngulo.position = CGPointMake(self.frame.width / 2, 30)
        labelAngulo.text = "testee"
        labelAngulo.fontSize = 40
        labelAngulo.color = UIColor.blackColor()
        addChild(labelAngulo)
        
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)

            
            
            let spriteTeste = SKSpriteNode(imageNamed: "5.png")
            
            teste.physicsBody?.angularVelocity = CGFloat(0.0)
            
            if location.x > self.size.width/2 {
                player.xScale = -1.0
                teste.physicsBody?.applyAngularImpulse(5.0)
            }
            else {
                player.xScale = 1.0
                teste.physicsBody?.applyAngularImpulse(-5.0)
            }
            
            player.physicsBody?.dynamic = true
            player.physicsBody?.affectedByGravity = false
            let dx = player.position.x - teste2.parent!.position.x
            let dy = -(player.position.y - teste2.parent!.position.y)
            player.physicsBody?.velocity = CGVector(dx: 0, dy: -10*dy)
            
            println(dx)
            println(dy)
            
            let rotationAngle = atan2(dy, dx) - CGFloat(M_PI_2)
            println(rotationAngle)
            player.runAction(SKAction.rotateToAngle(rotationAngle, duration: 0.01, shortestUnitArc: true))
//            player.physicsBody?.dynamic = false
            
            spriteTeste.size = CGSize(width: 299/10, height: 703/10)
            spriteTeste.position = location
            spriteTeste.name = "personagens"
            spriteTeste.physicsBody?.allowsRotation = true

            spriteTeste.physicsBody = SKPhysicsBody(rectangleOfSize: spriteTeste.size)
            spriteTeste.physicsBody?.affectedByGravity = true
            //self.addChild(spriteTeste)

        }
    }
   

    override func update(currentTime: CFTimeInterval) {
        let dx = player.position.x - teste2.parent!.position.x
        let dy = -(player.position.y - teste2.parent!.position.y)
//        player.physicsBody?.velocity = CGVector(dx: 0, dy: -10*dy)
        
        println(dx)
        println(dy)
        
        let rotationAngle = atan2(dy, dx) - CGFloat(M_PI_2)
        println(rotationAngle)
        player.runAction(SKAction.rotateToAngle(rotationAngle, duration: 0.01, shortestUnitArc: true))
        
    }
    
    func criarPlanetasComPosicao(posicao: CGPoint, raio:CGFloat, habilitarRegiao:Bool, raioAtmosfera:Float, falloff:Float, strenght:Float, imagem: String) -> SKSpriteNode {
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
        self.addChild(fieldNode)
        return imageFieldNode
        
    }
}

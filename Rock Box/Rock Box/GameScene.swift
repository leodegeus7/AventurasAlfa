//
//  GameScene.swift
//  Rock Box
//
//  Created by Leonardo Geus on 11/06/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

import SpriteKit

struct BitMasks {
    static let planeta:UInt32 = 0x01
    static let personagem:UInt32 = 0x02
    static let letra:UInt32 = 0x03
}



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    
    var labelAngulo:SKLabelNode!
    var teste:SKSpriteNode!
    var teste2 = SKSpriteNode()
    var teste3 = SKSpriteNode()
    var player = SKSpriteNode()
    var planetaTeste = SKSpriteNode()
    var cameraNode = SKSpriteNode()
    var gameNode = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        self.physicsWorld.contactDelegate = self
        
        self.addChild(gameNode)
        
        gameNode.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/15)
        
        cameraNode = SKSpriteNode(color: UIColor.blueColor(), size: self.size)
        
        gameNode.xScale = 1.5
        gameNode.yScale = 1.5
        
        gameNode.addChild(cameraNode)
        
//        cameraNode.position = CGPoint(x: gameNode.frame.width/2, y: gameNode.frame.height/2)
//        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        
        
        teste = self.criarPlanetasComPosicao(CGPointMake(0.0,0.0), raio: 200, habilitarRegiao:true,raioAtmosfera:100, falloff: 1, strenght: 1, imagem: "4.png")
        //Metodos.criarPlanetas(self, posicao: CGPointMake(self.frame.width / 2, self.frame.height), raio: 100,habilitarRegiao:false, raioAtmosfera:40, falloff: 1, strenght: 1, imagem: "2.png")
        //Metodos.criarPlanetas(self, posicao: CGPointMake(self.frame.width / 2, 0), raio: 100,habilitarRegiao:true,  raioAtmosfera:40 ,falloff: 1, strenght: 1, imagem: "3.png")
        
        teste2 = self.criarPlanetasComPosicao(CGPointMake(self.frame.width / 6 , 1/3 * self.frame.height), raio: 60, habilitarRegiao:true,raioAtmosfera:20, falloff: 0, strenght: 2, imagem: "4.png")
        
        teste3 = self.criarPlanetasComPosicao(CGPointMake(self.frame.width / 2 , 1/15 * self.frame.height), raio: 40, habilitarRegiao:true,raioAtmosfera:20, falloff: 0, strenght: 2, imagem: "3.png")
        

        
        
        
        
        let spriteTeste = SKSpriteNode(imageNamed: "5.png")
        spriteTeste.size = CGSize(width: 299/10, height: 703/10)
//        spriteTeste.position = CGPointMake(self.frame.width / 2, teste.parent!.position.y + teste.frame.size.height/2 + 40)
        spriteTeste.position = cameraNode.position
        spriteTeste.position.y = cameraNode.position.y + 55.0
        spriteTeste.name = "personagens"
        spriteTeste.physicsBody?.allowsRotation = false
        spriteTeste.physicsBody = SKPhysicsBody(rectangleOfSize: spriteTeste.size)
        spriteTeste.physicsBody?.affectedByGravity = true
        spriteTeste.physicsBody?.dynamic = false
        spriteTeste.physicsBody?.mass = 100
        spriteTeste.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        //spriteTeste.physicsBody?.applyForce(CGVector(dx: 10000, dy: 0))
        //spriteTeste.physicsBody?.applyImpulse(CGVector(dx: -100000, dy: 0))
        player = spriteTeste
        player.physicsBody?.fieldBitMask = BitMasks.personagem
        player.physicsBody?.contactTestBitMask = BitMasks.personagem
        player.physicsBody?.collisionBitMask = BitMasks.personagem
        player.physicsBody?.categoryBitMask = BitMasks.personagem
        
        gameNode.addChild(player)
        
        labelAngulo = SKLabelNode(fontNamed: "Arial")
        labelAngulo.position = CGPointMake(self.frame.width / 2, 30)
        labelAngulo.text = "testee"
        labelAngulo.fontSize = 40
        labelAngulo.color = UIColor.blackColor()
        gameNode.addChild(labelAngulo)
        
        

        criarLetras(teste2, angulo: 1.047, imagem: "6.png")

        
        criarLetras(teste, angulo: 0.047, imagem: "6.png")

        
        criarLetras(teste, angulo: 2.047, imagem: "6.png")

        
        criarLetras(teste2, angulo: 3.047, imagem: "6.png")

        
        criarLetras(teste2, angulo: 2.647, imagem: "6.png")

        
        criarLetras(teste, angulo: 0.447, imagem: "6.png")



        let pular = UISwipeGestureRecognizer(target: self, action: Selector("swipeUp:"))
        pular.direction = .Up
        view.addGestureRecognizer(pular)
        
        
        
        
        
        
        
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)

            
            
            let spriteTeste = SKSpriteNode(imageNamed: "5.png")
            
            teste.physicsBody?.angularVelocity = CGFloat(0.0)
            
            if location.x > self.size.width/2 {
                player.xScale = -1.0
                teste.runAction(SKAction.rotateByAngle(CGFloat(M_PI_2 / 5), duration: 1.0))
                cameraNode.runAction(SKAction.rotateByAngle(CGFloat(M_PI_2 / 5), duration: 1.0))
            }
            else {
                player.xScale = 1.0
                teste.runAction(SKAction.rotateByAngle(CGFloat(-M_PI_2 / 5), duration: 1.0))
                cameraNode.runAction(SKAction.rotateByAngle(CGFloat(-M_PI_2 / 5), duration: 1.0))
            }
            
            player.physicsBody?.dynamic = true
            player.physicsBody?.affectedByGravity = false
            let dx = player.position.x - teste2.parent!.position.x
            let dy = -(player.position.y - teste2.parent!.position.y)
//            player.physicsBody?.velocity = CGVector(dx: 0, dy: -10*dy)


            spriteTeste.size = CGSize(width: 299/10, height: 703/10)
            spriteTeste.position = location
            spriteTeste.name = "personagens"
            spriteTeste.physicsBody?.allowsRotation = true

            spriteTeste.physicsBody = SKPhysicsBody(rectangleOfSize: spriteTeste.size)
            spriteTeste.physicsBody?.affectedByGravity = true


        }
    }
    
    
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == BitMasks.personagem && contact.bodyB.categoryBitMask == BitMasks.letra {
            var bodyA = contact.bodyA
            var bodyB = contact.bodyB
            
            bodyB.node?.removeFromParent()
            
        }
        
        if contact.bodyA.categoryBitMask == BitMasks.letra && contact.bodyB.categoryBitMask == BitMasks.personagem {
            var bodyA = contact.bodyA
            var bodyB = contact.bodyB
            bodyA.node?.removeFromParent()

        }

    }
   

    override func update(currentTime: CFTimeInterval) {
        
        var campo1 = (teste.parent as! SKFieldNode)
        var campo2 = (teste2.parent as! SKFieldNode)
        var campo3 = (teste3.parent as! SKFieldNode)
//
        let dx = player.position.x - teste2.parent!.position.x
        let dy = (player.position.y - teste2.parent!.position.y)
        
        if (campo1.region.containsPoint(CGPoint(x: dx, y: dy))){
            println("PLANETA 1")
        
        }
        if (campo2.region.containsPoint(CGPoint(x: dx, y: dy))){
            println("PLANETA 2")
            
        }
        if (campo3.region.containsPoint(CGPoint(x: dx, y: dy))){
            println("PLANETA 3")
            
        }

        
        println("dx: \(dx) dy: \(dy)")
        player.physicsBody?.velocity = CGVector(dx: 0, dy: -10*dy)

        let rotationAngle = atan(dy/dx)
        

        
//        player.runAction(SKAction.rotateToAngle(rotationAngle, duration: 0.01, shortestUnitArc: true))
        
    }
    
    func criarPlanetasComPosicao(posicao: CGPoint, raio:CGFloat, habilitarRegiao:Bool, raioAtmosfera:Float, falloff:Float, strenght:Float, imagem: String) -> SKSpriteNode {
        var fieldNode = SKFieldNode.radialGravityField()
        fieldNode.falloff = falloff
        fieldNode.strength = strenght;
        fieldNode.animationSpeed = 0.5
        fieldNode.name = "fieldNode"
        if (habilitarRegiao){
            fieldNode.region = SKRegion(radius: Float(raio) + raioAtmosfera)
        }
        fieldNode.position = posicao
        fieldNode.enabled = true
        fieldNode.physicsBody = SKPhysicsBody(circleOfRadius: raio)
        fieldNode.physicsBody?.dynamic = false
        let fieldCategory: UInt32 = 0x1 << 1
        fieldNode.categoryBitMask = BitMasks.planeta
        
        fieldNode.physicsBody?.allowsRotation = true
        fieldNode.physicsBody?.applyAngularImpulse(100)
        var imageFieldNode = SKSpriteNode(imageNamed: imagem)
        imageFieldNode.size = CGSizeMake(raio*2, raio*2)
        imageFieldNode.physicsBody = SKPhysicsBody(circleOfRadius: raio)
        imageFieldNode.physicsBody?.dynamic = false
        imageFieldNode.position = CGPoint(x: 0, y: 0)
        imageFieldNode.physicsBody?.collisionBitMask = BitMasks.planeta
        imageFieldNode.physicsBody?.contactTestBitMask = BitMasks.planeta
        imageFieldNode.physicsBody?.fieldBitMask = BitMasks.planeta
        imageFieldNode.physicsBody?.categoryBitMask = BitMasks.planeta
        imageFieldNode.physicsBody?.affectedByGravity = false
        imageFieldNode.physicsBody?.applyAngularImpulse(100)
        fieldNode.addChild(imageFieldNode)
        
        fieldNode.zPosition = 10.0
        
        cameraNode.addChild(fieldNode)

        return imageFieldNode
    }
    
    func criarLetras(node:SKSpriteNode, angulo:CGFloat, imagem:String){
        var letra = SKSpriteNode(imageNamed: imagem)
        var raio = node.size.height / 2
        letra.size = CGSize (width: 299/14, height: 299/14)
        letra.position = CGPoint(x: (raio*sin(angulo))+letra.size.height*sin(angulo)/2, y: (raio*cos(angulo)+letra.size.height*cos(angulo)/2))
        letra.physicsBody = SKPhysicsBody(rectangleOfSize: letra.size)
        letra.physicsBody?.affectedByGravity = false
        letra.physicsBody?.dynamic = false
        var anguloF = (3.1415 - angulo) + CGFloat(M_PI)
        letra.zRotation = CGFloat(anguloF)
        letra.physicsBody?.collisionBitMask = BitMasks.letra
        letra.physicsBody?.contactTestBitMask = BitMasks.letra
        letra.physicsBody?.categoryBitMask = BitMasks.letra
        letra.physicsBody?.fieldBitMask = BitMasks.letra
        node.addChild(letra)
    
    }
    

    
//////////  METODOS QUE CRIAMOOS   
    
    func swipeUp (sender:UISwipeGestureRecognizer){
        
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 10000))
    }
    
    
    
    
    
}













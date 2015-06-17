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
    static let regiao:UInt32 = 0x04
}



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    
    var labelAngulo:SKLabelNode!
    var planeta1:SKSpriteNode!
    var planeta2 = SKSpriteNode()
    var planeta3 = SKSpriteNode()

    var planetaTeste = SKSpriteNode()
    var cameraNode = SKSpriteNode()
    var gameNode = SKSpriteNode()
    var contador:Float = 0
    var jogador = SKSpriteNode(imageNamed: "5.png")
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        self.physicsWorld.contactDelegate = self
        self.addChild(gameNode)
        gameNode.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/15)
        gameNode.xScale = 1.5
        gameNode.yScale = 1.5
        cameraNode = SKSpriteNode(color: UIColor.blueColor(), size: self.size)
        gameNode.addChild(cameraNode)
        
//        cameraNode.position = CGPoint(x: gameNode.frame.width/2, y: gameNode.frame.height/2)
//        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        
        
        
        //CRIAR PLANETAS
        
        planeta1 = self.criarPlanetasComPosicao(CGPointMake(0.0,0.0), raio: 200, habilitarRegiao:true,raioAtmosfera:703/10, falloff: 1, strenght: 1, imagem: "4.png", nome: "1")
        planeta2 = self.criarPlanetasComPosicao(CGPointMake(self.frame.width / 3.2 , 1/3 * self.frame.height), raio: 60, habilitarRegiao:true,raioAtmosfera:703/10, falloff: 0, strenght: 2, imagem: "4.png", nome: "2")
        //planeta3 = self.criarPlanetasComPosicao(CGPointMake(self.frame.width / 2 , 1/15 * self.frame.height), raio: 40, habilitarRegiao:true,raioAtmosfera:70, falloff: 0, strenght: 2, imagem: "3.png")
        
        
        
        //CRIAR PERSONAGEM
    
        
        
        jogador.size = CGSize(width: 299/10, height: 703/10)
        jogador.position = CGPoint(x: 0, y: 200 + (jogador.size.height / 2))
        jogador.name = "jogador"
        jogador.physicsBody = SKPhysicsBody(rectangleOfSize: jogador.size)
        jogador.physicsBody?.dynamic = true
        jogador.physicsBody?.mass = 1000
        jogador.physicsBody?.categoryBitMask = BitMasks.personagem
        jogador.physicsBody?.collisionBitMask = BitMasks.personagem
        jogador.physicsBody?.contactTestBitMask = BitMasks.letra | BitMasks.regiao
        jogador.physicsBody?.allowsRotation = false
        jogador.physicsBody?.affectedByGravity = true
        
        gameNode.addChild(jogador)
        

    
        
        
        
        //CRIAR LETRAS
        

        criarLetras(planeta2, angulo: 1.047, imagem: "6.png")
        criarLetras(planeta1, angulo: 0.047, imagem: "6.png")
        criarLetras(planeta1, angulo: 2.047, imagem: "6.png")
        criarLetras(planeta2, angulo: 3.047, imagem: "6.png")
        criarLetras(planeta2, angulo: 2.647, imagem: "6.png")
        criarLetras(planeta1, angulo: 0.447, imagem: "6.png")

        
        //OUTROS


        let pular = UISwipeGestureRecognizer(target: self, action: Selector("swipeUp:"))
        pular.direction = .Up
        view.addGestureRecognizer(pular)
        
        
        
    
        
        
        
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            planeta1.physicsBody?.angularVelocity = CGFloat(0.0)
            if location.x > self.size.width/2 {
                jogador.xScale = -1.0
                planeta1.runAction(SKAction.rotateByAngle(CGFloat(M_PI_2 / 5), duration: 1.0))
                cameraNode.runAction(SKAction.rotateByAngle(CGFloat(M_PI_2 / 5), duration: 1.0))
            }
            else {
                jogador.xScale = 1.0
                planeta1.runAction(SKAction.rotateByAngle(CGFloat(-M_PI_2 / 5), duration: 1.0))
                cameraNode.runAction(SKAction.rotateByAngle(CGFloat(-M_PI_2 / 5), duration: 1.0))
            }
            
//            player.physicsBody?.dynamic = true
//            player.physicsBody?.affectedByGravity = false
            let dx = jogador.position.x - planeta2.parent!.position.x
            let dy = -(jogador.position.y - planeta2.parent!.position.y)



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

        if contact.bodyA.categoryBitMask == BitMasks.regiao && contact.bodyB.categoryBitMask == BitMasks.personagem {
            var bodyA = contact.bodyA
            var bodyB = contact.bodyB
            if bodyA.node?.name == "1"{
                println("1")
            
            }
            if bodyB.node?.name == "2"{
                println("2")
                
            }
            
            
        }

        if contact.bodyA.categoryBitMask == BitMasks.personagem && contact.bodyB.categoryBitMask == BitMasks.regiao {
            var bodyA = contact.bodyA
            var bodyB = contact.bodyB
            if bodyB.node?.name == "1"{
                println("1")
                
            }
            if bodyB.node?.name == "2"{
                println("2")
                
            }
            
        }
        

    }
   

    override func update(currentTime: CFTimeInterval) {
        
        var campo1 = (planeta1.parent as! SKFieldNode)
        var campo2 = (planeta2.parent as! SKFieldNode)
        //var campo3 = (planeta3.parent as! SKFieldNode)
//
        let dx = jogador.position.x - jogador.parent!.position.x
        let dy = (jogador.position.y - jogador.parent!.position.y)
        
        var x = jogador.position.x
        var y = jogador.position.y
        
//        if (campo1.region.containsPoint(CGPoint(x: x, y: y))){
//            println("PLANETA 1")
//        }
//        if (campo2.region.containsPoint(CGPoint(x: x, y: y))){
//            contador++
//            println("PLANETA 2        \(contador)")
//        }
//        if (campo3.region.containsPoint(CGPoint(x: x, y: y))){
//            println("PLANETA 3")
//        }

        
//        println("dx: \(dx) dy: \(dy)")
        //jogador.physicsBody?.velocity = CGVector(dx: 0, dy: -10*dy)

        let rotationAngle = atan(dy/dx)
        

        
//        player.runAction(SKAction.rotateToAngle(rotationAngle, duration: 0.01, shortestUnitArc: true))
        
    }
    
    func criarPlanetasComPosicao(posicao: CGPoint, raio:CGFloat, habilitarRegiao:Bool, raioAtmosfera:Float, falloff:Float, strenght:Float, imagem: String, nome: String) -> SKSpriteNode {
        var fieldNode = SKFieldNode.radialGravityField()
        fieldNode.falloff = falloff
        fieldNode.strength = strenght;
        fieldNode.animationSpeed = 0.5
        fieldNode.name = "fieldNode"
        if (habilitarRegiao){fieldNode.region = SKRegion(radius: Float(raio) + raioAtmosfera)}
        fieldNode.position = posicao
        fieldNode.enabled = true
        fieldNode.physicsBody = SKPhysicsBody(circleOfRadius: raio)
        fieldNode.physicsBody?.dynamic = false
        let fieldCategory: UInt32 = 0x1 << 1
        fieldNode.categoryBitMask = BitMasks.planeta
        fieldNode.physicsBody?.allowsRotation = false
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
        
        var regiaoPlaneta = SKSpriteNode()
        regiaoPlaneta.position = CGPoint(x: 0, y: 0)
        regiaoPlaneta.physicsBody = SKPhysicsBody(circleOfRadius: raio + CGFloat(raioAtmosfera))
        regiaoPlaneta.color = UIColor.redColor()
        regiaoPlaneta.physicsBody?.dynamic = false
        regiaoPlaneta.physicsBody?.affectedByGravity = false
        regiaoPlaneta.physicsBody?.fieldBitMask = 0x0
        regiaoPlaneta.physicsBody?.categoryBitMask = BitMasks.regiao
        regiaoPlaneta.physicsBody?.contactTestBitMask = BitMasks.regiao | BitMasks.personagem
        regiaoPlaneta.physicsBody?.collisionBitMask = BitMasks.regiao
        regiaoPlaneta.name = nome
        fieldNode.addChild(regiaoPlaneta)
        
        
        

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
        letra.physicsBody?.mass = 1
        var anguloF = (3.1415 - angulo) + CGFloat(M_PI)
        letra.zRotation = CGFloat(anguloF)
        letra.physicsBody?.collisionBitMask = BitMasks.letra | BitMasks.personagem
        letra.physicsBody?.contactTestBitMask = BitMasks.letra | BitMasks.personagem
        letra.physicsBody?.categoryBitMask = BitMasks.letra
        letra.physicsBody?.fieldBitMask = BitMasks.letra
        node.addChild(letra)
    
    }
    

    
//////////  METODOS QUE CRIAMOOS   
    
    func swipeUp (sender:UISwipeGestureRecognizer){
        
        jogador.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100000))
    }
    
    
    
    
    
}













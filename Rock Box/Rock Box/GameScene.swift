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
    static let estrela:UInt32 = 0x05
}



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var jsonResult:NSDictionary!
    
    var labelAngulo:SKLabelNode!
    var planeta1:SKSpriteNode!
    var planeta2 = SKSpriteNode()
    var planeta3 = SKSpriteNode()
    var planetaTeste = SKSpriteNode()
    var cameraNode = SKSpriteNode()
    var gameNode = SKSpriteNode()
    var contador:Float = 0
    var jogador = SKSpriteNode(imageNamed: "5.png")
    var planetaUser = ""
    var arrayPlanetas = Array<SKSpriteNode>()
    var arrayLetras = Array<SKSpriteNode>()
    var arrayEstrelas = Array<SKSpriteNode>()
    var pausar = false
    var hud = SKSpriteNode()
    var estrelaDoHud1 = SKSpriteNode(imageNamed: "estrel.png")
    var estrelaDoHud2 = SKSpriteNode(imageNamed: "estrel.png")
    var estrelaDoHud3 = SKSpriteNode(imageNamed: "estrel.png")
    
    
    override func didMoveToView(view: SKView) {
        
        println(DataManager.instance.faseEscolhida)
        
        //Lendo arquivo Json
        
        //DataManager.instance.moverJsonParaDocuments()
        
//        var planet1 = (DataManager.instance.arrayDaFase(DataManager.instance.faseEscolhida)[0] as! Dictionary <String, AnyObject>)
//        var planet2 = (DataManager.instance.arrayDaFase(1)[1] as! Dictionary <String, AnyObject>)
//        var planet3 = (DataManager.instance.arrayDaFase(1)[2] as! Dictionary <String, AnyObject>)
        
        
        // Configuracoes do mundo e a camera
        
        
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        self.physicsWorld.contactDelegate = self
        self.addChild(gameNode)
        gameNode.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/15)
        gameNode.xScale = 1.0
        gameNode.yScale = 1.0
        gameNode.addChild(cameraNode)
        let backgroundNode = SKSpriteNode(imageNamed: "background.jpg")
        backgroundNode.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        backgroundNode.size = self.size
        backgroundNode.zPosition = -10
      //  backgroundNode.position = CGPoint(x: 0, y: self.size.height/2)
        
        self.addChild(backgroundNode)
       // gameNode.addChild(backgroundNode)


        
        
        //CRIAR PLANETAS
        var fase = DataManager.instance.arrayDaFase(DataManager.instance.faseEscolhida)
        
        
        for planetas in fase {
            var planetasDic = planetas as! Dictionary<String,AnyObject>
            var planetasSprite:SKSpriteNode = criarPlanetasComPosicao(CGPoint(x: CGFloat(planetasDic["coordenadaX"] as! CGFloat), y: CGFloat(planetasDic["coordenadaY"] as! CGFloat)), raio: CGFloat(planetasDic["raioPlaneta"] as! CGFloat), habilitarRegiao: true, raioAtmosfera: Float(planetasDic["raioAtmosfera"] as! Float), falloff: 0.5, strenght: 0.5, imagem: "2.png", nome: "Planeta 1")
            arrayPlanetas.append(planetasSprite)
        }
        
        
        
        
        planeta1 = arrayPlanetas[0]
        
        
        
//        planeta1 = criarPlanetasComPosicao(CGPoint(x: CGFloat(planet1["coordenadaX"] as! CGFloat), y: CGFloat(planet1["coordenadaY"] as! CGFloat)), raio: CGFloat(planet1["raioPlaneta"] as! CGFloat), habilitarRegiao: true, raioAtmosfera: Float(planet1["raioAtmosfera"] as! Float), falloff: 0.5, strenght: 0.5, imagem: "2.png", nome: "Planeta 1")
//        planeta2 = criarPlanetasComPosicao(CGPoint(x: CGFloat(planet2["coordenadaX"] as! CGFloat), y: CGFloat(planet2["coordenadaY"] as! CGFloat)), raio: CGFloat(planet2["raioPlaneta"] as! CGFloat), habilitarRegiao: true, raioAtmosfera: Float(planet2["raioAtmosfera"] as! Float), falloff: 0.5, strenght: 0.5, imagem: "4.png", nome: "Planeta 1")
//        planeta3 = criarPlanetasComPosicao(CGPoint(x: CGFloat(planet3["coordenadaX"] as! CGFloat), y: CGFloat(planet3["coordenadaY"] as! CGFloat)), raio: CGFloat(planet3["raioPlaneta"] as! CGFloat), habilitarRegiao: true, raioAtmosfera: Float(planet3["raioAtmosfera"] as! Float), falloff: 0.5, strenght: 0.5, imagem: "3.png", nome: "Planeta 1")
        
        
    
        
        //        planeta1 = self.criarPlanetasComPosicao(CGPointMake(0,0), raio: 200, habilitarRegiao:true,raioAtmosfera:703/10, falloff: 1, strenght: 1, imagem: "4.png", nome: "planeta1")
        //        planeta2 = self.criarPlanetasComPosicao(CGPointMake(cameraNode.frame.size.width / 5 , cameraNode.frame.size.height / 5), raio: 60, habilitarRegiao:true,raioAtmosfera:703/10, falloff: 1, strenght: 1, imagem: "3.png", nome: "planeta2")
        //        //planeta3 = self.criarPlanetasComPosicao(CGPointMake(self.frame.width / 2 , 1/15 * self.frame.height), raio: 40, habilitarRegiao:true,raioAtmosfera:70, falloff: 0, strenght: 2, imagem: "3.png")
        
        //CRIAR PERSONAGEM
    
        
        jogador.size = CGSize(width: 299/10, height: 703/10)
        jogador.position = CGPoint(x: 0, y: 200 + (jogador.size.height / 2) + 4)
        jogador.name = "jogador"
        jogador.physicsBody = SKPhysicsBody(rectangleOfSize: jogador.size)
        jogador.physicsBody?.dynamic = false
        jogador.physicsBody?.mass = 1000
        jogador.physicsBody?.categoryBitMask = BitMasks.personagem
        jogador.physicsBody?.collisionBitMask = BitMasks.personagem
        jogador.physicsBody?.contactTestBitMask = BitMasks.letra | BitMasks.regiao
        jogador.physicsBody?.allowsRotation = false
        jogador.physicsBody?.affectedByGravity = true
        
        
        gameNode.addChild(jogador)
        
    
        //CRIAR LETRAS
        
        var letras = DataManager.instance.arrayDasLetras(DataManager.instance.faseEscolhida)
        
        for letra in letras {
            var letrasDic = letra as! Dictionary<String,AnyObject>
            
            if letrasDic["planeta"] as! String == "planeta1" {
                
                var letraSprite:SKSpriteNode =  criarLetras(arrayPlanetas[0], angulo: letrasDic["angulo"] as! CGFloat, imagem: letrasDic["imagem"] as! String, nome: letrasDic["nome"] as! String)
                arrayPlanetas.append(letraSprite)
            }
            else  if letrasDic["planeta"] as! String == "planeta2" {
                
                var letraSprite:SKSpriteNode =  criarLetras(arrayPlanetas[1], angulo: letrasDic["angulo"] as! CGFloat, imagem: letrasDic["imagem"] as! String, nome: letrasDic["nome"] as! String)
                arrayPlanetas.append(letraSprite)
            }
            else  if letrasDic["planeta"] as! String == "planeta3" {
                
                var letraSprite:SKSpriteNode =  criarLetras(arrayPlanetas[2], angulo: letrasDic["angulo"] as! CGFloat, imagem: letrasDic["imagem"] as! String, nome: letrasDic["nome"] as! String)
                arrayPlanetas.append(letraSprite)
            }
            else  if letrasDic["planeta"] as! String == "planeta4" {
                
                var letraSprite:SKSpriteNode =  criarLetras(arrayPlanetas[3], angulo: letrasDic["angulo"] as! CGFloat, imagem: letrasDic["imagem"] as! String, nome: letrasDic["nome"] as! String)
                arrayPlanetas.append(letraSprite)
            }

        }
        
        
        
        
        //CRIAR ESTRELAS
        
        var estrelas = DataManager.instance.arrayDasEstrelas(DataManager.instance.faseEscolhida)
        
        for estrela  in estrelas {
            var estrelasDic = estrela as! Dictionary<String,AnyObject>
            
            if estrelasDic["planeta"] as! String == "planeta1" {
                
                var estrelaSprite:SKSpriteNode =  criarEstrelas(arrayPlanetas[0], angulo: estrelasDic["angulo"] as! CGFloat)
                arrayPlanetas.append(estrelaSprite)
            }
            else  if estrelasDic["planeta"] as! String == "planeta2" {
                
                var estrelaSprite:SKSpriteNode =  criarEstrelas(arrayPlanetas[1], angulo: estrelasDic["angulo"] as! CGFloat)
                arrayPlanetas.append(estrelaSprite)
            }
            else  if estrelasDic["planeta"] as! String == "planeta3" {
                
                var estrelaSprite:SKSpriteNode =  criarEstrelas(arrayPlanetas[2], angulo: estrelasDic["angulo"] as! CGFloat)
                arrayPlanetas.append(estrelaSprite)
            }
            else  if estrelasDic["planeta"] as! String == "planeta4" {
                
                var estrelaSprite:SKSpriteNode =  criarEstrelas(arrayPlanetas[3], angulo: estrelasDic["angulo"] as! CGFloat)
                arrayPlanetas.append(estrelaSprite)
            }
            
        }
        
    

        
        //OUTROS


        let pular = UISwipeGestureRecognizer(target: self, action: Selector("swipeUp:"))
        pular.direction = .Up
        view.addGestureRecognizer(pular)
        
        
        //HUD NODE
        
        
        self.addChild(hud)
        
        estrelaDoHud1.position = CGPoint(x: 50, y:50)
        estrelaDoHud2.position = CGPoint(x: 150, y: 50)
        estrelaDoHud3.position = CGPoint(x: 250, y: 50)
        
        estrelaDoHud1.size = CGSize(width: 50, height: 50)
        estrelaDoHud2.size = CGSize(width: 50, height: 50)
        estrelaDoHud3.size = CGSize(width: 50, height: 50)
        
        hud.addChild(estrelaDoHud1)
        hud.addChild(estrelaDoHud2)
        hud.addChild(estrelaDoHud3)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            
            jogador.physicsBody?.dynamic = true
            let location = touch.locationInNode(self)
            planeta1.physicsBody?.angularVelocity = CGFloat(0.0)
            if location.x > self.size.width/2 && location.y < self.size.height/2 {
                jogador.xScale = -1.0
                planeta1.runAction(SKAction.rotateByAngle(CGFloat(M_PI_2 / 5), duration: 1.0))
                cameraNode.runAction(SKAction.rotateByAngle(CGFloat(M_PI_2 / 5), duration: 1.0))
                //planeta2.runAction(SKAction.rotateByAngle(CGFloat(M_PI_2 / 5), duration: 1.0))
            }
            else if location.x < self.size.width/2 && location.y < self.size.height/2 {
                jogador.xScale = 1.0
                planeta1.runAction(SKAction.rotateByAngle(CGFloat(-M_PI_2 / 5), duration: 1.0))
                cameraNode.runAction(SKAction.rotateByAngle(CGFloat(-M_PI_2 / 5), duration: 1.0))
                //planeta2.runAction(SKAction.rotateByAngle(CGFloat(M_PI_2 / 5), duration: 1.0))
            }
            
//            player.physicsBody?.dynamic = true
//            player.physicsBody?.affectedByGravity = false
            let dx = jogador.position.x - planeta1.parent!.position.x
            let dy = -(jogador.position.y - planeta1.parent!.position.y)



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
            if bodyA.node?.name == "planeta1"{
                println("planeta1")
                planetaUser = "planeta1"

            
            }
            if bodyB.node?.name == "planeta2"{
                println("planeta1")
                planetaUser = "planeta1"
                cameraNode.anchorPoint = CGPoint(x: 100, y: 2000)
            }
            
            
        }
        
        
        if contact.bodyA.categoryBitMask == BitMasks.estrela && contact.bodyB.categoryBitMask == BitMasks.personagem {
            var bodyA = contact.bodyA
            var bodyB = contact.bodyB
            
            bodyA.node?.removeFromParent()
            DataManager.instance.numeroEstrelas++
            acenderEstrelas()
            
            
        }

        if contact.bodyA.categoryBitMask == BitMasks.personagem && contact.bodyB.categoryBitMask == BitMasks.estrela {
            var bodyA = contact.bodyA
            var bodyB = contact.bodyB
            bodyB.node?.removeFromParent()
            DataManager.instance.numeroEstrelas++
            acenderEstrelas()
            
            
        }

        if contact.bodyA.categoryBitMask == BitMasks.personagem && contact.bodyB.categoryBitMask == BitMasks.regiao {
            var bodyA = contact.bodyA
            var bodyB = contact.bodyB
            if bodyB.node?.name == "planeta1"{
                println("planeta1")
                planetaUser = "planeta1"
                
            }
            if bodyB.node?.name == "planeta2"{
                println("planeta2")
                planetaUser = "planeta2"
                
                let dx = (planeta2.parent!.position.x - planeta1.parent!.position.x)
                let dy = (planeta2.parent!.position.y - planeta1.parent!.position.y - planeta1.parent!.frame.size.height/2 + planeta2.parent!.frame.size.height/2)
                
                println("\(dx) \(dy)")
                
                println(planeta2.parent!.position)
                gameNode.position = CGPoint(x: dx, y: dy)
              //  planeta1.parent!.position = CGPoint(x: planeta1.parent!.position.x - dx, y: planeta1.parent!.position.y - dy)
               // planeta2.parent!.position = CGPoint(x: planeta2.parent!.position.x - dx, y: planeta2.parent!.position.y - dy)
                
                println("\(planeta1.parent!.position ) \(planeta2.parent!.position)")
                
            }
            
        }
        

    }
   

    override func update(currentTime: CFTimeInterval) {
        
        var campo1 = (planeta1.parent as! SKFieldNode)
        //var campo2 = (planeta2.parent as! SKFieldNode)
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
        
        
        
        if DataManager.instance.pausar {
            self.paused = true
        
        }
        else {
            self.paused = false
        }
        
        

        
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
    
    func criarLetras(node:SKSpriteNode, angulo:CGFloat, imagem:String, nome:String) -> SKSpriteNode {
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
        
        return letra
    
    }
    
    func criarEstrelas(node:SKSpriteNode, angulo:CGFloat) -> SKSpriteNode{
        var estrela = SKSpriteNode(imageNamed: "estrela.png")
        var raio = node.size.height / 2
        estrela.size = CGSize (width: 299/14, height: 299/14)
        estrela.position = CGPoint(x: (raio*sin(angulo))+estrela.size.height*sin(angulo)/2, y: (raio*cos(angulo)+estrela.size.height*cos(angulo)/2))
        estrela.physicsBody = SKPhysicsBody(rectangleOfSize: estrela.size)
        estrela.physicsBody?.affectedByGravity = false
        estrela.physicsBody?.dynamic = false
        estrela.physicsBody?.mass = 1
        var anguloF = (3.1415 - angulo) + CGFloat(M_PI)
        estrela.zRotation = CGFloat(anguloF)
        estrela.physicsBody?.collisionBitMask = BitMasks.estrela | BitMasks.personagem
        estrela.physicsBody?.contactTestBitMask = BitMasks.estrela | BitMasks.personagem
        estrela.physicsBody?.categoryBitMask = BitMasks.estrela
        estrela.physicsBody?.fieldBitMask = BitMasks.estrela
        node.addChild(estrela)
        
        return estrela
    }
    

    
//////////  METODOS QUE CRIAMOOS   
    
    func swipeUp (sender:UISwipeGestureRecognizer){
        
        jogador.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 900000))
    }
    
    
    
    func acenderEstrelas() {
        if DataManager.instance.numeroEstrelas == 1 {
            estrelaDoHud1.texture = SKTexture(imageNamed: "estrela.png")
            
        }
        else if DataManager.instance.numeroEstrelas == 2 {
            estrelaDoHud1.texture = SKTexture(imageNamed: "estrela.png")
            estrelaDoHud2.texture = SKTexture(imageNamed: "estrela.png")
            
        }
        else if DataManager.instance.numeroEstrelas >= 3 {
        estrelaDoHud1.texture = SKTexture(imageNamed: "estrela.png")
            estrelaDoHud2.texture = SKTexture(imageNamed: "estrela.png")
            estrelaDoHud3.texture = SKTexture(imageNamed: "estrela.png")
            
        }
    }
    
    
    
 
    
}













//
//  GameScene.swift
//  Rock Box
//
//  Created by Leonardo Geus on 11/06/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
////

import SpriteKit


struct BitMasks {
    static let planeta:UInt32 = 0x01
    static let personagem:UInt32 = 0x02
    static let letra:UInt32 = 0x03
    static let regiao:UInt32 = 0x04
    static let estrela:UInt32 = 0x05
    static let particulas:UInt32 = 0x06
}



class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var jsonResult:NSDictionary!
    
    var planetaIndex = 0
    
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
    var estrelaDoHud1 = SKSpriteNode(imageNamed: "estrelaApagada.png")
    var estrelaDoHud2 = SKSpriteNode(imageNamed: "estrelaApagada.png")
    var estrelaDoHud3 = SKSpriteNode(imageNamed: "estrelaApagada.png")
    
    var palavraDaFaseArray:Array<Character>!
    var numeroDaLetraAtual = 0
    
    var planetaAtual = SKSpriteNode()
    var anguloAtual = CGFloat(M_PI_2)
    
    var swipePoints = (initial:CGPoint(), final:CGPoint(), actual:CGPoint())
    
    var isTouched = false
    var longPressMinInterval = 0.5
    var lastUntouchedTime = CFTimeInterval()
    
    var moveDelay = 0.1
    var lastMoveTime = CFTimeInterval()
    
    enum moveDirection{
        case left
        case right
        case planet
    }
    
    override func didMoveToView(view: SKView) {
        
        println(DataManager.instance.faseEscolhida)
        
        
        // Configuracoes do mundo e a camera
        
        
        self.physicsWorld.gravity = CGVectorMake(0.0, 0.0)
        self.physicsWorld.contactDelegate = self
        self.addChild(gameNode)
        gameNode.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/4)
        gameNode.size = self.size
        gameNode.xScale = 0.6
        gameNode.yScale = 0.6
        gameNode.addChild(cameraNode)
        
        
        let backgroundNode = SKSpriteNode(imageNamed: "background.jpg")
        backgroundNode.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        backgroundNode.size = self.size
        backgroundNode.zPosition = -10
        self.addChild(backgroundNode)
        
        
        //CRIAR PLANETAS
        var fase = DataManager.instance.arrayDaFase(DataManager.instance.faseEscolhida)
        for planetas in fase {
            var planetasDic = planetas as! Dictionary<String,AnyObject>
            var stringImagem =  planetasDic["imagem"] as! String
            var planetasSprite:SKSpriteNode = criarPlanetasComPosicao(CGPoint(x: CGFloat(planetasDic["coordenadaX"] as! CGFloat), y: CGFloat(planetasDic["coordenadaY"] as! CGFloat)), raio: CGFloat(planetasDic["raioPlaneta"] as! CGFloat), habilitarRegiao: true, raioAtmosfera: Float(planetasDic["raioAtmosfera"] as! Float), falloff: 0.5, strenght: 0.5, imagem: "\(stringImagem)", nome: "Planeta \(arrayPlanetas.count)")
            arrayPlanetas.append(planetasSprite)
        }
        planetaAtual = arrayPlanetas[1]
        
        
        
        
        //CRIAR PERSONAGEM
        
        
        
        jogador.size = CGSize(width: 299/10, height: 703/10)
        
        let origem = planetaAtual.position
        let raio  = planetaAtual.frame.size.height/2 + jogador.size.height/2
        
        let posX = cameraNode.position.x + origem.x + raio * cos(anguloAtual)
        let posY = cameraNode.position.y + origem.y + raio * sin(anguloAtual)
        
        jogador.zRotation = anguloAtual - CGFloat(M_PI_2)
        
        jogador.position = CGPoint(x: posX, y: posY)
        
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
        
        var arquivo = (((DataManager.instance.lerArquivoJson())[DataManager.instance.faseEscolhida - 1] as! Dictionary<String,AnyObject>)["palavra"] as! String)
        
        
        palavraDaFaseArray = Array(arquivo)
        
        
        
        //OUTROS
        
        
        //        let pular = UISwipeGestureRecognizer(target: self, action: Selector("swipeUp:"))
        //        pular.direction = .Up
        //        view.addGestureRecognizer(pular)
        //
        
        
        
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
        
        //ESTRELAS PARTÍCULAS
        
        var particulasEstrelas = SKEmitterNode(fileNamed: "stars.sks")
        

        particulasEstrelas.position = CGPoint(x: 0, y: self.frame.height / 2)
        particulasEstrelas.zPosition = -1
        gameNode.addChild(particulasEstrelas)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            
            swipePoints.initial = location
            
            swipePoints.actual = swipePoints.initial
            
            isTouched = true
            
            
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            
            swipePoints.actual = location
            
        }
    }
    
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self)
            
            swipePoints.final = location
            
            isTouched = false
            
            let dx = fabs(swipePoints.final.x - swipePoints.initial.x)
            let dy = fabs(swipePoints.final.y - swipePoints.initial.y)
            
            if (dx > 20 || dy > 20) {
                let jumpVectorSize = CGFloat(70000)
                let jumpVector = CGVector(dx: jumpVectorSize * cos(anguloAtual), dy: jumpVectorSize * sin(anguloAtual))
                
                jogador.physicsBody?.applyImpulse(jumpVector)
                
            }
            
        }
    }
    
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == BitMasks.personagem && contact.bodyB.categoryBitMask == BitMasks.letra {
            var bodyA = contact.bodyA
            var bodyB = contact.bodyB
            
            if String(palavraDaFaseArray[numeroDaLetraAtual]) == bodyB.node!.name && (numeroDaLetraAtual < palavraDaFaseArray.count)
            {
                bodyB.node?.removeFromParent()
                numeroDaLetraAtual++
            }
            
        }
        
        if contact.bodyA.categoryBitMask == BitMasks.letra && contact.bodyB.categoryBitMask == BitMasks.personagem {
            var bodyA = contact.bodyA
            var bodyB = contact.bodyB
            
            if String(palavraDaFaseArray[0]) == bodyB.node!.name && (numeroDaLetraAtual < palavraDaFaseArray.count)
            {
                bodyA.node?.removeFromParent()
                numeroDaLetraAtual++
            }
            
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
            var personagem = SKSpriteNode()
            var regiao = SKSpriteNode()
            
            if contact.bodyA.categoryBitMask == BitMasks.personagem {
                personagem = contact.bodyA.node as! SKSpriteNode
                regiao = contact.bodyB.node as! SKSpriteNode
            }
            else {
                personagem = contact.bodyB.node as! SKSpriteNode
                regiao = contact.bodyA.node as! SKSpriteNode
            }
            
            if planetaAtual.name != regiao.name {
                for planeta in arrayPlanetas {
                    if planeta.name == regiao.name {
                        planetaAtual = planeta
                        println("trocou para \(planeta.name)")
                        movePlayerWithDirection(.planet)
                    }
                }
                
            }
            
            println(regiao.name)
            
        }

        if contact.bodyA.categoryBitMask == BitMasks.particulas && contact.bodyB.categoryBitMask == BitMasks.regiao {
            var bodyA = contact.bodyA
            var bodyB = contact.bodyB
            bodyA.node?.removeFromParent()
        }
        if contact.bodyA.categoryBitMask == BitMasks.regiao && contact.bodyB.categoryBitMask == BitMasks.particulas {
            var bodyA = contact.bodyA
            var bodyB = contact.bodyB
            bodyB.node?.removeFromParent()

            
            
        }
        
        
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        
        handleLongPressWithUpdate(currentTime)
        
        if DataManager.instance.pausar {
            self.paused = true
            
        }
        else {
            self.paused = false
        }
        
        
        
    }
    
    ///FUNCAO DE CRIAR OS NODES - PLANETAS,ESTRELAS E LETRAS
    
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
        imageFieldNode.name = nome
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
        regiaoPlaneta.physicsBody?.contactTestBitMask = BitMasks.regiao | BitMasks.personagem | BitMasks.particulas
        regiaoPlaneta.physicsBody?.collisionBitMask = BitMasks.regiao
        regiaoPlaneta.name = nome
        fieldNode.addChild(regiaoPlaneta)
        var particulas = SKEmitterNode()
        switch imagem {
            case "2.png":
                    particulas = SKEmitterNode(fileNamed: "amarelo.sks")
            case "3.png":
                    particulas = SKEmitterNode(fileNamed: "vermelho.sks")
            case "4.png":
                    particulas = SKEmitterNode(fileNamed: "azul.sks")
            default:
                    particulas = SKEmitterNode(fileNamed: "azul.sks")
        
        }

        if raio < 80 { //condicoes de planeta mt pequeno
            particulas.particleLifetime = 5
            particulas.particleBirthRate = 30
            particulas.speed = 3
            particulas.particleColor = UIColor.redColor()
            particulas.particlePositionRange = CGVector(dx: imageFieldNode.size.width + imageFieldNode.size.width*0.8, dy: imageFieldNode.size.height + imageFieldNode.size.height*0.8)}
        particulas.position = CGPoint(x: 0, y: 0)
        particulas.zPosition = -1
        if raio >= 80 {
            particulas.particlePositionRange = CGVector(dx: imageFieldNode.size.width + imageFieldNode.size.width*0.25, dy: imageFieldNode.size.height + imageFieldNode.size.height*0.25)
        }
        particulas.alpha = 0.7
        particulas.physicsBody?.categoryBitMask = BitMasks.particulas
        particulas.physicsBody?.collisionBitMask = BitMasks.regiao | BitMasks.particulas
        particulas.physicsBody?.contactTestBitMask = BitMasks.particulas | BitMasks.regiao
        
        regiaoPlaneta.addChild(particulas)
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
        letra.name = nome
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
    
    func movePlayerWithDirection (direction : moveDirection) {
        
        var moveDuration = moveDelay
        
        switch (direction) {
        case .left:
            anguloAtual+=0.10
            jogador.xScale = 1.0
        case .right:
            anguloAtual-=0.10
            jogador.xScale = -1.0
        case .planet:
            anguloAtual -= CGFloat(M_PI)
            moveDuration = 10 * moveDelay
        }
        
        
        let origem = planetaAtual.parent!.position
        let raio  = planetaAtual.frame.size.height/2 + jogador.size.height/2
        let posX = origem.x + raio * cos(anguloAtual)
        let posY = origem.y + raio * sin(anguloAtual)
        
        let posX2 = cameraNode.position.x + origem.x + raio * cos(anguloAtual)
        let posY2 = cameraNode.position.y + origem.y + raio * sin(anguloAtual)
        
        
        let translacao = SKAction.moveTo(CGPoint(x: posX, y: posY), duration: moveDuration)
        
        let rotacao = SKAction.rotateToAngle(anguloAtual - CGFloat(M_PI_2), duration: moveDuration, shortestUnitArc: true)
    
        jogador.runAction(SKAction.group([translacao,rotacao]))
        
    }
    
    func handleLongPressWithUpdate(currentTime: CFTimeInterval) {
        if(!isTouched) {
            lastUntouchedTime = currentTime
            return
        }
        else {
            if (currentTime - lastUntouchedTime > longPressMinInterval) {
                println("longPress!!!")
                
                if (currentTime - lastMoveTime > moveDelay) {
                    println(swipePoints.initial.x)
                    println((jogador.position.x * gameNode.xScale))
                    if swipePoints.actual.x > self.size.height/2 {
                        movePlayerWithDirection(moveDirection.right)
                        
                    }
                    else if swipePoints.actual.x < self.size.height/2 {
                        movePlayerWithDirection(moveDirection.left)
                    }
                    lastMoveTime = currentTime
                }
            }
        }
    }
    
    
}
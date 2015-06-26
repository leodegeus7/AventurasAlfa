//
//  GameViewController.swift
//  Rock Box
//
//  Created by Leonardo Geus on 11/06/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation


extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {

    @IBOutlet weak var viewPalavra: UIView!
    @IBOutlet weak var imagePalavra: UIImageView!
    @IBOutlet weak var estrela1: UIImageView!
    @IBOutlet weak var estrela2: UIImageView!
    @IBOutlet weak var estrela3: UIImageView!
    
    @IBOutlet weak var botaoDoSom: UIButton!
    
    @IBOutlet weak var estrelaDoHud1: UIImageView!
    @IBOutlet weak var estrelaDoHud2: UIImageView!
    @IBOutlet weak var estrelaDoHud3: UIImageView!
    
    @IBOutlet weak var objetoDaFaseMiniatura: UIImageView!
    
    @IBOutlet weak var hudView: UIView!
    @IBOutlet weak var fundoDoHudImageView: UIImageView!
    
    @IBOutlet weak var voltarPraFasesOutlet: UIButton!
    
    @IBOutlet weak var reiniciarFasesOutlet: UIButton!
    
    @IBOutlet weak var proximaFaseOutlet: UIButton!
    
    @IBOutlet weak var viewFundo: UIImageView!
    
    @IBOutlet weak var botaoFechar: UIButton!
    
    var audioPlayer = AVAudioPlayer()
    
    var arrayDasLetrasPause = Array<UIImageView>()
    var arrayDasLetrasHud = Array<UIImageView>()
    
    var arrayDosRiscosPause = Array<UIImageView>()
    
    var arrayDosRiscosHud = Array<UIImageView>()
    
    var gameScene = GameScene()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer1.stop()
        audioPlayer2.play()
        audioPlayer2.numberOfLoops = -1
        
        botaoFechar.hidden = false

        
        criarRiscosELetrasHud()
        criarRiscosELetrasPause()
        esconderBotoes()
    
        viewPalavra.layer.cornerRadius = 36
        viewPalavra.layer.masksToBounds = true
        
        viewPalavra.alpha = 1

        initEstrelas()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateHud:", name: "UpdateHud", object: nil)
        
        
       
//        var cor = UIColor(red: 154.0/255, green: 114.0/255, blue: 218.0/255, alpha: 0.45).CGColor
//        viewPalavra.layer.backgroundColor = cor//

        
        
        
        
        
        switch DataManager.instance.faseEscolhida {
        case 1 :
            imagePalavra.image = UIImage(named: "Casa.png")
            objetoDaFaseMiniatura.image = UIImage(named: "Casa.png")
        case 2 :
            imagePalavra.image = UIImage(named: "Agua.png")
            objetoDaFaseMiniatura.image = UIImage(named: "Agua.png")
        case 3 :
            imagePalavra.image = UIImage(named: "Cenoura.png")
            objetoDaFaseMiniatura.image = UIImage(named: "Cenoura.png")
        case 4 :
            imagePalavra.image = UIImage(named: "Calça")
            objetoDaFaseMiniatura.image = UIImage(named: "Calça")
        case 5 :
            imagePalavra.image = UIImage(named: "ccarro.png")
            objetoDaFaseMiniatura.image = UIImage(named: "ccarro.png")
        case 6 :
            imagePalavra.image = UIImage(named: "Chuva.png")
            objetoDaFaseMiniatura.image = UIImage(named: "Chuva.png")
        case 7 :
            imagePalavra.image = UIImage(named: "Olho.png")
            objetoDaFaseMiniatura.image = UIImage(named: "Olho.png")
        case 8 :
            imagePalavra.image = UIImage(named: "Hospital.png")
            objetoDaFaseMiniatura.image = UIImage(named: "Hospital.png")
        case 9 :
            imagePalavra.image = UIImage(named: "2.png")
            objetoDaFaseMiniatura.image = UIImage(named: "2.png")
        default :
            imagePalavra.image = UIImage(named: "2.png")
            objetoDaFaseMiniatura.image = UIImage(named: "2.png")
            
            
        }
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsPhysics = false
            skView.showsFields = false
            skView.showsNodeCount = true
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        
            gameScene = scene
            updateHud(NSNotification(name: "Updatehud", object: nil))
        }
    }

    override func viewDidAppear(animated: Bool) {
        playSound()
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func esconderBotoes()
    {
        reiniciarFasesOutlet.hidden = true
        proximaFaseOutlet.hidden = true
    }
    
    func aparecerBotoes()
    {
        reiniciarFasesOutlet.hidden = false
    }
    @IBAction func somPalavra(sender: UIButton) {
        if !audioPlayer.playing
        {
        playSound()
        }
    }
    
    
    @IBAction func exitButton(sender: AnyObject) {
        viewPalavra.hidden = true
        DataManager.instance.pausar = false
        
    }
    
    func acenderEstrelas() {
        if DataManager.instance.numeroEstrelas == 1 {
            estrela1.image = UIImage(named: "estrela.png")
        
        }
        else if DataManager.instance.numeroEstrelas == 2 {
            estrela1.image = UIImage(named: "estrela.png")
            estrela2.image = UIImage(named: "estrela.png")
        
        }
        else if DataManager.instance.numeroEstrelas >= 3 {
            estrela1.image = UIImage(named: "estrela.png")
            estrela2.image = UIImage(named: "estrela.png")
            estrela3.image = UIImage(named: "estrela.png")
        
        }
    }
    
    func criarRiscosELetrasHud () {
        
        var arquivo = (((DataManager.instance.lerArquivoJson())[DataManager.instance.faseEscolhida - 1] as! Dictionary<String,AnyObject>)["palavra"] as! String)
        
        var palavraFase = Array(arquivo)
        
        let posicaoInicial = CGPoint(x: 370 , y: 98.0)
        let posicaoFinal = CGPoint(x: 620 , y: 98.0)
        
        let espacoRiscos = (posicaoFinal.x - posicaoInicial.x) * 8 / 9
        let tamanhoRisco = espacoRiscos / CGFloat(palavraFase.count)
        
        let espacoVazio = (posicaoFinal.x - posicaoInicial.x) * 1 / 9
        let tamanhoEspaco = espacoVazio / CGFloat(palavraFase.count)
        
        let tamanhoLetra = CGSize(width: tamanhoRisco, height: tamanhoRisco * 742 / 559 )
        
        for var i = 0; i < palavraFase.count; i++ {
            
            var riscoDasLetrasHud = UIImageView(image: UIImage(named: "Line.png"))
            riscoDasLetrasHud.bounds.size = CGSize(width: tamanhoRisco, height: riscoDasLetrasHud.bounds.size.height)
            
            riscoDasLetrasHud.layer.position = CGPoint(x: posicaoInicial.x + CGFloat(i) * (tamanhoRisco + tamanhoEspaco), y: posicaoInicial.y)
            
            hudView.addSubview(riscoDasLetrasHud)
            arrayDosRiscosHud.append(riscoDasLetrasHud)
            
            var letra = "\(palavraFase[i])"
            letra = "\(letra.capitalizedString).png"
            
            let imagemDaLetra = UIImageView(image: UIImage(named: letra))
            imagemDaLetra.bounds.size = tamanhoLetra
            imagemDaLetra.layer.position = CGPoint(x: riscoDasLetrasHud.layer.position.x, y: riscoDasLetrasHud.layer.position.y - (tamanhoLetra.height/2))

            hudView.addSubview(imagemDaLetra)
            imagemDaLetra.hidden = true
            arrayDasLetrasHud.append(imagemDaLetra)
            
        }
    }
    
    func criarRiscosELetrasPause () {
        
        var arquivo = (((DataManager.instance.lerArquivoJson())[DataManager.instance.faseEscolhida - 1] as! Dictionary<String,AnyObject>)["palavra"] as! String)
        
        var palavraFase = Array(arquivo)
        
        
        let posicaoInicial = CGPoint(x: 88 , y: 280)
        let posicaoFinal = CGPoint(x: 469 , y: 280)
        
        let espacoRiscos = (posicaoFinal.x - posicaoInicial.x) * 8 / 9
        let tamanhoRisco = espacoRiscos / CGFloat(palavraFase.count)
        
        let espacoVazio = (posicaoFinal.x - posicaoInicial.x) * 1 / 9
        let tamanhoEspaco = espacoVazio / CGFloat(palavraFase.count)
        
        let tamanhoLetra = CGSize(width: tamanhoRisco, height: tamanhoRisco * 742 / 559 )
        
        
        for var i = 0; i < palavraFase.count; i++ {
            var riscoDasLetrasPause = UIImageView(image: UIImage(named: "Line.png"))
            riscoDasLetrasPause.bounds.size = CGSize(width: tamanhoRisco, height: riscoDasLetrasPause.bounds.size.height)
            
            riscoDasLetrasPause.layer.position = CGPoint(x: posicaoInicial.x + CGFloat(i) * (tamanhoRisco + tamanhoEspaco), y: posicaoInicial.y)
            viewPalavra.addSubview(riscoDasLetrasPause)
            arrayDosRiscosPause.append(riscoDasLetrasPause)
            var letra = "\(palavraFase[i])"
            letra = "\(letra.capitalizedString).png"
            
            let imagemDaLetra = UIImageView(image: UIImage(named: letra))
            imagemDaLetra.layer.position = CGPoint(x: riscoDasLetrasPause.layer.position.x, y: riscoDasLetrasPause.layer.position.y - (tamanhoLetra.height/2))
            imagemDaLetra.bounds.size = tamanhoLetra
            viewPalavra.addSubview(imagemDaLetra)
            imagemDaLetra.hidden = true
            arrayDasLetrasPause.append(imagemDaLetra)
            
        }
        
        println("Inicial: \(posicaoInicial) Final: \(posicaoFinal)")

        
        
    }

    func updateTheStars () {
        NSNotificationCenter.defaultCenter().postNotificationName("UpdateStars", object: nil)
        
    }
    
    func resetTheGame () {
        NSNotificationCenter.defaultCenter().postNotificationName("ResetGame", object: nil)
    }

    
    func updateHud(notification:NSNotification){
        for var i=0; i < gameScene.numeroDaLetraAtual ; i++ {
            arrayDasLetrasHud[i].hidden = false
            arrayDasLetrasPause[i].hidden = false
            botaoFechar.hidden = true
        }
        
        if gameScene.numeroDaLetraAtual == arrayDasLetrasHud.count
        {
            viewPalavra.hidden = false
            if !(DataManager.instance.faseEscolhida == 8) {
            proximaFaseOutlet.hidden = false
            }
           
        }
        switch gameScene.numeroDeEstrelasAtual {
        case 1 :
            estrelaDoHud1.image = UIImage(named: "estrela.png")
            estrela1.image = UIImage(named: "estrela.png")
        case 2 :
            estrelaDoHud2.image = UIImage(named: "estrela.png")
            estrela2.image = UIImage(named: "estrela.png")
        case 3 :
            estrelaDoHud3.image = UIImage(named: "estrela.png")
            estrela3.image = UIImage(named: "estrela.png")
        default :
            initEstrelas()
        }
    }
    
    func playSound() {
        var fase = DataManager.instance.arrayDaFaseAntes(DataManager.instance.faseEscolhida)
        var stringFase = fase["palavra"] as! String
        switch stringFase {
        case "casa":
            var som = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("casa", ofType: "wav")!)
            audioPlayer = AVAudioPlayer(contentsOfURL: som, error: nil)
        case "olho":
            var som = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("olho", ofType: "wav")!)
            audioPlayer = AVAudioPlayer(contentsOfURL: som, error: nil)
        case "cenoura":
            var som = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cenoura", ofType: "wav")!)
            audioPlayer = AVAudioPlayer(contentsOfURL: som, error: nil)
        case "chuva":
            var som = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("chuva", ofType: "wav")!)
            audioPlayer = AVAudioPlayer(contentsOfURL: som, error: nil)
        case "calça":
            var som = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("calca", ofType: "wav")!)
            audioPlayer = AVAudioPlayer(contentsOfURL: som, error: nil)
        case "agua":
            var som = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("agua", ofType: "wav")!)
            audioPlayer = AVAudioPlayer(contentsOfURL: som, error: nil)
        case "carro":
            var som = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("carro", ofType: "wav")!)
            audioPlayer = AVAudioPlayer(contentsOfURL: som, error: nil)
        case "hospital":
            var som = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("hospital", ofType: "wav")!)
            audioPlayer = AVAudioPlayer(contentsOfURL: som, error: nil)
        default:
            println("NAO ACHOU SOOM")
            var som = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("eu_sou_o_alfa", ofType: "wav")!)
            audioPlayer = AVAudioPlayer(contentsOfURL: som, error: nil)
            
        }
        
        
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func initEstrelas() {
        estrelaDoHud1.image = UIImage(named: "estrelaApagada.png")
        estrelaDoHud2.image = UIImage(named: "estrelaApagada.png")
        estrelaDoHud3.image = UIImage(named: "estrelaApagada.png")
    }
    
    func tirarOsRisquinhos()
    {
        for risco in arrayDosRiscosPause
        {
            risco.removeFromSuperview()
            
        }
        
        for risco in arrayDosRiscosHud
        {
            risco.removeFromSuperview()
        }
    }
    
    func tirarLetras()
    {
       for letra in arrayDasLetrasHud
        
       {
        letra.removeFromSuperview()
        }
        
        for letra in arrayDasLetrasPause
        {
            letra.removeFromSuperview()
        }
        
        arrayDasLetrasHud.removeAll(keepCapacity: false)
        arrayDasLetrasPause.removeAll(keepCapacity: false)
    }
    @IBAction func repetirSom(sender: AnyObject) {
        if !audioPlayer.playing{
        playSound()
        }
    }
    
    @IBAction func voltarPrasFases(sender: AnyObject) {
        DataManager.instance.pausar = true
        viewFundo.image = UIImage(named: "janela1.png")
        viewPalavra.hidden = false
        aparecerBotoes()

    }
    
    @IBAction func voltarPraTelaDeFases(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        audioPlayer1.play()
        audioPlayer2.stop()
        updateTheStars()
        
        
    }
    @IBAction func jogarNovamente(sender: AnyObject) {
        tirarOsRisquinhos()
        tirarLetras()
        gameScene.resetVars()
        
        self.viewDidLoad()
    }
    

    
    
    @IBAction func irParaProximaFase(sender: AnyObject) {
        DataManager.instance.pausar = true
        estrela1.image = UIImage(named: "estrelaApagada.png")
        estrela2.image = UIImage(named: "estrelaApagada.png")
        estrela3.image = UIImage(named: "estrelaApagada.png")
        DataManager.instance.faseEscolhida!++
        tirarOsRisquinhos()
        tirarLetras()
        playSound()
        self.viewDidLoad()
        
    }
}


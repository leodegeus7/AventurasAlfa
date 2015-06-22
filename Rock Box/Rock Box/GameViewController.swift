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
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        var arquivo = (((DataManager.instance.lerArquivoJson())[DataManager.instance.faseEscolhida - 1] as! Dictionary<String,AnyObject>)["palavra"] as! String)
        
        var palavraFase = Array(arquivo)
        
        
      
        var divisoes = viewPalavra.bounds.width/(CGFloat(2*palavraFase.count))
        
        for var i = 0; i < Int(palavraFase.count); i++

        {
            var riscoDasLetras = UIImageView(image: UIImage(named: "Line.png"))
            riscoDasLetras.bounds.size = CGSize(width: riscoDasLetras.bounds.size.width*0.5, height: riscoDasLetras.bounds.size.height)
            
            riscoDasLetras.frame = CGRect(origin: CGPoint(x: viewPalavra.bounds.width/10 + (riscoDasLetras.bounds.width + 10)*CGFloat(i) , y: botaoDoSom.frame.origin.y + botaoDoSom.bounds.height), size: riscoDasLetras.bounds.size)
             viewPalavra.addSubview(riscoDasLetras)
        }
        
        
        
        
    
        viewPalavra.layer.cornerRadius = 20
        viewPalavra.layer.masksToBounds = true
        
        viewPalavra.alpha = 1
        
       
//        var cor = UIColor(red: 154.0/255, green: 114.0/255, blue: 218.0/255, alpha: 0.45).CGColor
//        
//        
//        viewPalavra.layer.backgroundColor = cor

        viewPalavra.layer.backgroundColor = UIColor(patternImage: UIImage(named: "Mask.png")!).CGColor
        
        switch DataManager.instance.faseEscolhida {
        case 1 :
            imagePalavra.image = UIImage(named: "casa.png")
        case 2 :
            imagePalavra.image = UIImage(named: "agua.png")
        case 3 :
            imagePalavra.image = UIImage(named: "2.png")
        case 4 :
            imagePalavra.image = UIImage(named: "2.png")
        case 5 :
            imagePalavra.image = UIImage(named: "2.png")
        case 6 :
            imagePalavra.image = UIImage(named: "2.png")
        case 7 :
            imagePalavra.image = UIImage(named: "2.png")
        case 8 :
            imagePalavra.image = UIImage(named: "2.png")
        default :
            imagePalavra.image = UIImage(named: "2.png")
            
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
        
            
        }
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
    
     
    @IBAction func somPalavra(sender: UIButton) {
        var fase = DataManager.instance.arrayDaFaseAntes(DataManager.instance.faseEscolhida)
        var stringFase = fase["palavra"] as! String
//        var som = NSURL()
        switch stringFase {
            case "casa":
                var som = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("casa", ofType: "wav")!)
                audioPlayer = AVAudioPlayer(contentsOfURL: som, error: nil)
            case "olho":
                var som = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("olho", ofType: "wav")!)
                audioPlayer = AVAudioPlayer(contentsOfURL: som, error: nil)
            case "calca":
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
    
}


//
//  EscolhaDaFaseViewController.swift
//  Rock Box
//
//  Created by Leonardo Piovezan on 6/18/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
/////////

import UIKit

class EscolhaDaFaseViewController: UIViewController {
    
    @IBOutlet weak var primeiraFase: UIButton!
    @IBOutlet weak var segundaFase: UIButton!
    @IBOutlet weak var terceiraFase: UIButton!
    @IBOutlet weak var quartaFase: UIButton!
    @IBOutlet weak var quintaFase: UIButton!
    @IBOutlet weak var sextaFase: UIButton!
    @IBOutlet weak var setimaFase: UIButton!
    @IBOutlet weak var oitavaFase: UIButton!
    @IBOutlet weak var nonaFase: UIButton!
    @IBOutlet var viewPlanetas: UIView!
    @IBOutlet weak var estrelasFase1: UIImageView!
    @IBOutlet weak var estrelasFase2: UIImageView!
    @IBOutlet weak var estrelasFase3: UIImageView!
    @IBOutlet weak var estrelasFase4: UIImageView!
    @IBOutlet weak var estrelasFase5: UIImageView!
    @IBOutlet weak var estrelasFase6: UIImageView!
    @IBOutlet weak var estrelasFase7: UIImageView!
    @IBOutlet weak var estrelasFase8: UIImageView!
    @IBOutlet weak var estrelasFase9: UIImageView!
    
    var faseAtual = GameViewController()
    
    @IBAction func irParaFase1(sender: AnyObject) {
        DataManager.instance.faseEscolhida = 1
    }
    
    
    @IBAction func irParaFase2(sender: AnyObject) {
        DataManager.instance.faseEscolhida = 2
    }
 
    
    @IBAction func irParaFase3(sender: AnyObject) {
        
        DataManager.instance.faseEscolhida = 3
    }
    
    @IBAction func irParaFase4(sender: AnyObject) {
        DataManager.instance.faseEscolhida = 4
    }
    
    
    @IBAction func irParaFase5(sender: AnyObject) {
        DataManager.instance.faseEscolhida = 5
    }
    
    
    @IBAction func irParaFase6(sender: AnyObject) {
        DataManager.instance.faseEscolhida = 6
    }
    
    @IBAction func irParaFase7(sender: AnyObject) {
        DataManager.instance.faseEscolhida = 7
    }
    
    @IBAction func irParaFase8(sender: AnyObject) {
        DataManager.instance.faseEscolhida = 8
    
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateStars", name: "UpdateStars", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetGame", name: "ResetGame", object: nil)
        var json = DataManager.instance.lerArquivoJson()
        var fases = DataManager.instance.arrayDaFaseAntes(1)
        var estrelas:Int!
        
        var arrayDasEstrelas = [estrelasFase1,estrelasFase2,estrelasFase3,estrelasFase4,estrelasFase5,estrelasFase6,estrelasFase7,estrelasFase8,estrelasFase9]
        var arrayDosPlanetas = [primeiraFase,segundaFase,terceiraFase,quartaFase,quintaFase,sextaFase,setimaFase,oitavaFase,nonaFase]
        
        for index in 1...json.count{
            fases = DataManager.instance.arrayDaFaseAntes(index)
            estrelas = fases["quantasEstrelasPegou"] as! Int
            let jaJogou = fases["jaJogou"] as! Bool
           
            var nomeImagemEstrela = String()
            
            if index == 5 {
                
            }
            
            if estrelas == 1 {
                nomeImagemEstrela = "estrela_1.png"
            }
            else if estrelas == 2 {
                nomeImagemEstrela = "estrela_2.png"
            }
            else if estrelas == 3 {
                nomeImagemEstrela = "estrela_3.png"
            }
            
            
            
            arrayDasEstrelas[index-1].image = UIImage(named: nomeImagemEstrela)
            
            if index < json.count {
                if jaJogou  {
                    arrayDosPlanetas[index].enabled = true
                }
                else {
                    arrayDosPlanetas[index].enabled = false
                }
            }
            
            
        }
        
        

        
        

       
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func mudarEstrelas (imagem:UIImage,fase:Int) {
        var estrelas = UIImageView(image: imagem)
        
        
        estrelas.frame.size = CGSize(width: 225/1.7, height: 81/1.7)
        viewPlanetas.addSubview(estrelas)
    }
    

    
    func updateStars () {
        viewDidLoad()
        
    
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        faseAtual = segue.destinationViewController as! GameViewController
    }

}

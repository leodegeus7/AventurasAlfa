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

        var json = DataManager.instance.lerArquivoJson()
        var fases = DataManager.instance.arrayDaFaseAntes(1)
        var estrelas:Int!
        
        
        for index in 1...json.count{
                fases = DataManager.instance.arrayDaFaseAntes(index)
                estrelas = fases["quantasEstrelasPegou"] as! Int

            if estrelas == 0 {
                mudarEstrelas(UIImage(named: "planetavermelho.png")!, fase: index+1)
            }
            else if estrelas == 1 {
                mudarEstrelas(UIImage(named: "menu_planeta_1estrela.png")!, fase: index+1)
            }
            else if estrelas == 2 {
                mudarEstrelas(UIImage(named: "menu_planeta_2estrela.png")!, fase: index+1)
            }
            else if estrelas == 3 {
                mudarEstrelas(UIImage(named: "menu_planeta_3estrela.png")!, fase: index+1)
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
        switch fase {
        case 1:
            primeiraFase.setImage(imagem, forState: UIControlState.Normal)

            break
        case 2:
            segundaFase.setImage(imagem, forState: UIControlState.Normal)
            break
        case 3:
            terceiraFase.setImage(imagem, forState: UIControlState.Normal)
            break
        case 4:
            quartaFase.setImage(imagem, forState: UIControlState.Normal)
            break
        case 5:
            quintaFase.setImage(imagem, forState: UIControlState.Normal)
            break
        case 6:
            sextaFase.setImage(imagem, forState: UIControlState.Normal)
            break
        case 7:
            setimaFase.setImage(imagem, forState: UIControlState.Normal)
            break
        case 8:
            oitavaFase.setImage(imagem, forState: UIControlState.Normal)
            break
        case 9:
            nonaFase.setImage(imagem, forState: UIControlState.Normal)
            break
        default:
            break
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

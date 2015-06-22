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

            if estrelas == 1 {
                mudarEstrelas(UIImage(named: "estrela_1.png")!, fase: index+1)
            }
            else if estrelas == 2 {
                mudarEstrelas(UIImage(named: "estrela_2.png")!, fase: index+1)
            }
            else if estrelas == 3 {
                mudarEstrelas(UIImage(named: "estrela_3.png")!, fase: index+1)
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
        switch fase {
        case 1:
            posicaoEstrelas(estrelas, fase: primeiraFase)
            
            break
        case 2:
            posicaoEstrelas(estrelas, fase: segundaFase)
            break
        case 3:
            posicaoEstrelas(estrelas, fase: terceiraFase)
            break
        case 4:
            posicaoEstrelas(estrelas, fase: quartaFase)
            break
        case 5:
            posicaoEstrelas(estrelas, fase: quintaFase)
            break
        case 6:
            posicaoEstrelas(estrelas, fase: sextaFase)
            break
        case 7:
            posicaoEstrelas(estrelas, fase: setimaFase)
            break
        case 8:
            posicaoEstrelas(estrelas, fase: oitavaFase)
            break
        case 9:
            posicaoEstrelas(estrelas, fase: nonaFase)
            break
        default:
            break
        }
        
        estrelas.frame.size = CGSize(width: 225/1.7, height: 81/1.7)
        self.view.addSubview(estrelas)
    }
    
    func posicaoEstrelas (estrelas:UIImageView,fase:UIButton) {
            estrelas.layer.position = CGPoint(x: fase.layer.position.x + fase.frame.width*(3/4) - 5, y: fase.layer.position.y - fase.frame.height*(3/4) + 20)
    
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

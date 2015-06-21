//
//  EscolhaDaFaseViewController.swift
//  Rock Box
//
//  Created by Leonardo Piovezan on 6/18/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
/////////

import UIKit

class EscolhaDaFaseViewController: UIViewController {
    
    
    
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
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

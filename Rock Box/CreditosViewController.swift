//
//  CreditosViewController.swift
//  Rock Box
//
//  Created by Leonardo Koppe Malanski on 26/06/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

import UIKit

class CreditosViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

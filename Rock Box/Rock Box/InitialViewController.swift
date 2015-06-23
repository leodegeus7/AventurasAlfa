//
//  InitialViewController.swift
//  Rock Box
//
//  Created by Leonardo Koppe Malanski on 22/06/15.
//  Copyright (c) 2015 Leonardo Geus. All rights reserved.
//

import UIKit
import AVFoundation

var audioPlayer1 = AVAudioPlayer()
var audioPlayer2 = AVAudioPlayer()



class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var er:NSError?
        var music1 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("menu", ofType: "mp3")!)
        var music2 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ambiente", ofType: "mp3")!)
        
        var erro:NSError?
        audioPlayer1 = AVAudioPlayer(contentsOfURL: music1, error: &erro)
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: &erro)
        audioPlayer1.play()
        
        audioPlayer2 = AVAudioPlayer(contentsOfURL: music2, error: &erro)
        audioPlayer2.prepareToPlay()
        
        // Do any additional setup after loading the view.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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

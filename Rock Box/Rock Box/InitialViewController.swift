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
        //var er:NSError?
        let music1 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("menu", ofType: "mp3")!)
        let music2 = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ambiente", ofType: "mp3")!)
        
        var erro:NSError?
        do {
            audioPlayer1 = try AVAudioPlayer(contentsOfURL: music1)
        } catch let error as NSError {
            erro = error
            audioPlayer1.pause()
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        } catch _ {
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            erro = error
        }
        audioPlayer1.play()
        
        do {
            audioPlayer2 = try AVAudioPlayer(contentsOfURL: music2)
        } catch let error as NSError {
            erro = error
            audioPlayer2.pause()
        }
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

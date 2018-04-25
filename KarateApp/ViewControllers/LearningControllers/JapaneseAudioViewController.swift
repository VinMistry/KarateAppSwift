//
//  JapaneseAudioViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 28/02/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit
import AVFoundation
class JapaneseAudioViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
        // Do any additional setup after loading the view.
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Ohayougozaimasu" , ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSound(_ sender: UIButton) {
        audioPlayer.play()
    }
    
    @IBAction func pauseSound(_ sender: UIButton) {
        if(audioPlayer.isPlaying){
            audioPlayer.pause()
        }
        else{
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

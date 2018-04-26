//
//  JapaneseAudioTableViewCell.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 25/04/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit
import AVFoundation
class JapaneseAudioTableViewCell: UITableViewCell {

    var audioPlayer = AVAudioPlayer()
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        if(!audioPlayer.isPlaying){
            audioPlayer.play()
        }
    }
    
    @IBOutlet weak var playPause: UILabel!
    
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        if(audioPlayer.isPlaying){
            audioPlayer.pause()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  JapaneseAudioViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 28/02/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit
import AVFoundation
class JapaneseAudioViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource, ExpandableHeaderViewDelegate  {
    
    var audioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var optionSelected: UILabel!
    
    var arrayToDisplay : [JapaneseAudioSection] = [JapaneseAudioSection(section: "Good Morning", expanded: false), JapaneseAudioSection(section: "Hello", expanded: false)]
    
    var urlArray = [URL.init(fileURLWithPath: Bundle.main.path(forResource: "Ohayougozaimasu" , ofType: "mp3")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "flock-of-seagulls_daniel-simion" , ofType: "mp3")!)]
    
    var audioPlayers : [AVAudioPlayer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        optionSelected.text = "Listen"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayToDisplay.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(arrayToDisplay[indexPath.section].expanded){
            return 44
        }
        else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: arrayToDisplay[section].section, section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "learningAudio")! as? JapaneseAudioTableViewCell else {
            return UITableViewCell()
        }
        do {
            audioPlayer =  try AVAudioPlayer(contentsOf: urlArray[indexPath.row])
          //  audioPlayers![indexPath.section] = audioPlayer
            audioPlayer.prepareToPlay()
        }
        catch {
            print(error)
        }
        cell.audioPlayer = audioPlayer
        cell.audioPlayer.prepareToPlay()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            audioPlayer =  try AVAudioPlayer(contentsOf: urlArray[indexPath.section])
            audioPlayer.prepareToPlay()
        }
        catch {
            print(error)
        }
        if(audioPlayer.isPlaying){
             audioPlayer.pause()
        }
        else{
            //audioPlayers![indexPath.section].play()
            let cell = tableView.cellForRow(at: indexPath) as? JapaneseAudioTableViewCell
            cell?.audioPlayer.play()
        }
    }
    
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        arrayToDisplay[section].expanded = !arrayToDisplay[section].expanded
        tableView.beginUpdates()
        
        tableView.endUpdates()
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

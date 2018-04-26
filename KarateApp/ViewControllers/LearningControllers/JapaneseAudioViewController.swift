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
    
    var greetingsArray : [JapaneseAudioSection] = [
        JapaneseAudioSection(section: "Good Morning", expanded: false),
        JapaneseAudioSection(section: "Hello/Good Day", expanded: false),
        JapaneseAudioSection(section: "Good Evening",  expanded: false),
        JapaneseAudioSection(section: "Good Night",  expanded: false),
        JapaneseAudioSection(section: "Goodbye",  expanded: false),
        JapaneseAudioSection(section: "Goodbye (Formal)", expanded: false)]
    
    var numberArray = [
        JapaneseAudioSection(section: "1", expanded: false),
        JapaneseAudioSection(section: "2", expanded: false),
        JapaneseAudioSection(section: "3", expanded: false),
        JapaneseAudioSection(section: "4", expanded: false),
        JapaneseAudioSection(section: "5", expanded: false),
        JapaneseAudioSection(section: "6", expanded: false),
        JapaneseAudioSection(section: "7", expanded: false),
        JapaneseAudioSection(section: "8", expanded: false),
        JapaneseAudioSection(section: "9", expanded: false),
        JapaneseAudioSection(section: "10", expanded: false),
    ]
    
    var coloursArray : [JapaneseAudioSection] = [
        JapaneseAudioSection(section: "Colour", expanded: false),
        JapaneseAudioSection(section: "White", expanded: false),
        JapaneseAudioSection(section: "Red", expanded: false),
        JapaneseAudioSection(section: "Yellow", expanded: false),
        JapaneseAudioSection(section: "Orange", expanded: false),
        JapaneseAudioSection(section: "Green",  expanded: false),
        JapaneseAudioSection(section: "Blue", expanded: false),
        JapaneseAudioSection(section: "Purple", expanded: false),
        JapaneseAudioSection(section: "Brown", expanded: false),
        JapaneseAudioSection(section: "Black", expanded: false),
        JapaneseAudioSection(section: "Pink", expanded: false),
        JapaneseAudioSection(section: "Gray", expanded: false)]
    
   var arrayToUse : [JapaneseAudioSection]!
    
    //These audio files are from https://www.rocketlanguages.com/
    var urlArrayGreetings = [URL.init(fileURLWithPath: Bundle.main.path(forResource: "G1" , ofType: "mp3")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "G2" , ofType: "mp3")!),URL.init(fileURLWithPath: Bundle.main.path(forResource: "G3" , ofType: "mp3")!),URL.init(fileURLWithPath: Bundle.main.path(forResource: "G4" , ofType: "mp3")!),URL.init(fileURLWithPath: Bundle.main.path(forResource: "G5" , ofType: "mp3")!),URL.init(fileURLWithPath: Bundle.main.path(forResource: "G6" , ofType: "mp3")!)]
    
   //These audio files are from https://audiograb.com/PzlswssB
     var urlArrayNumbers = [
        URL.init(fileURLWithPath: Bundle.main.path(forResource: "1" , ofType: "wav")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "2" , ofType: "wav")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "3" , ofType: "wav")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "4" , ofType: "wav")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "5" , ofType: "wav")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "6" , ofType: "wav")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "7" , ofType: "wav")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "8" , ofType: "wav")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "9" , ofType: "wav")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "10" , ofType: "wav")!)]
    
     //These audio files are from https://www.rocketlanguages.com/
     var urlArrayTechniques = [  URL.init(fileURLWithPath: Bundle.main.path(forResource: "C1" , ofType: "mp3")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "C2" , ofType: "mp3")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "C3" , ofType: "mp3")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "C4" , ofType: "mp3")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "C5" , ofType: "mp3")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "C6" , ofType: "mp3")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "C7" , ofType: "mp3")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "C8" , ofType: "mp3")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "C9" , ofType: "mp3")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "C10" , ofType: "mp3")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "C11" , ofType: "mp3")!), URL.init(fileURLWithPath: Bundle.main.path(forResource: "C12" , ofType: "mp3")!)]
    
    var audioPlayers : [AVAudioPlayer]?
    
    var urlsToUse : [URL]!
    
    var optionSelect : String = "None" {
        didSet {
            if(optionSelect == "Greetings"){
                urlsToUse = urlArrayGreetings
                arrayToUse = greetingsArray
            }
            else if(optionSelect == "Numbers"){
                urlsToUse = urlArrayNumbers
                arrayToUse = numberArray
            }
            else{
                urlsToUse = urlArrayTechniques
                arrayToUse = coloursArray
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        optionSelected.text = "Listen to \(optionSelect)"
        
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayToUse.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(arrayToUse[indexPath.section].expanded){
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
        header.customInit(title: arrayToUse[section].section, section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "learningAudio")! as? JapaneseAudioTableViewCell else {
            return UITableViewCell()
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let path = urlsToUse[indexPath.section]
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: path )
            audioPlayer.play()
        }
        catch {
            
        }
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        arrayToUse[section].expanded = !arrayToUse[section].expanded
        tableView.beginUpdates()
        for i in 0 ..< 1{
            tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
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

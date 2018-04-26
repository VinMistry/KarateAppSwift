//
//  JapaneseTextViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 28/02/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit

class JapaneseTextViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource, ExpandableHeaderViewDelegate  {

    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var greetingSections = [
        JapaneseTextSection(section: "Good Morning", textToAdd: ["Ohayō gozaimasu", "Hiragana: おはよう　ございます", "Kanji: お早う御座います"], expanded: false),
        JapaneseTextSection(section: "Hello/Good Day", textToAdd: ["Konnichiwa", "Hiragana: こんにちは", "Kanji: 今日は"], expanded: false),
          JapaneseTextSection(section: "Good Evening", textToAdd: ["Konbanwa", "Hiragana: こんばんは"], expanded: false),
         JapaneseTextSection(section: "Good Night", textToAdd: ["Oyasumi nasai", "Hiragana: おやすみ　なさい"], expanded: false),
         JapaneseTextSection(section: "Goodbye", textToAdd: ["Sayōnara", "Hiragana: さようなら"], expanded: false),
         JapaneseTextSection(section: "Goodbye (Formal)", textToAdd: ["Shitsurei shimasu", "Hiragana: しつれい　します", "Kanji: 失礼します"], expanded: false)
    ]
    
    var numberSections = [
        JapaneseTextSection(section: "0", textToAdd: ["Zero", "0"], expanded: false),
        JapaneseTextSection(section: "1", textToAdd: ["Ichi", "一"], expanded: false),
        JapaneseTextSection(section: "2", textToAdd: ["Ni", "二"], expanded: false),
        JapaneseTextSection(section: "3", textToAdd: ["San", "三"], expanded: false),
        JapaneseTextSection(section: "4", textToAdd: ["Shi", "四"], expanded: false),
        JapaneseTextSection(section: "5", textToAdd: ["Go", "五"], expanded: false),
        JapaneseTextSection(section: "6", textToAdd: ["Roku","六"], expanded: false),
        JapaneseTextSection(section: "7", textToAdd: ["Shichi","七"], expanded: false),
        JapaneseTextSection(section: "8", textToAdd: ["Hachi", "八 "], expanded: false),
        JapaneseTextSection(section: "9", textToAdd: ["Kyū", "九"], expanded: false),
        JapaneseTextSection(section: "10", textToAdd: ["Jū","十"], expanded: false),
        JapaneseTextSection(section: "11", textToAdd: ["Jū Ichi", "十一"], expanded: false),
        JapaneseTextSection(section: "100", textToAdd: ["Hyaku", "百"], expanded: false)
    
    ]
    
    var colourSections = [
        JapaneseTextSection(section: "Colour", textToAdd: ["Iro", "Kanji: 色", "Hiragana: いろ"], expanded: false),
        JapaneseTextSection(section: "White", textToAdd: ["Shiro", "Kanji: 白", "Hiragana: しろ"], expanded: false),
        JapaneseTextSection(section: "Red", textToAdd: ["Aka", "Kanji: 赤", "Hiragana: あか"], expanded: false),
        JapaneseTextSection(section: "Yellow", textToAdd: ["Ki-iro", "Kanji: 黄色" , "Hiragana: きいろ"], expanded: false),
        JapaneseTextSection(section: "Orange", textToAdd: ["Orenji", "Hiragana: オレンジ"], expanded: false),
        JapaneseTextSection(section: "Green", textToAdd: ["Midori", "Kanji: 緑", "Hiragana: みどり"], expanded: false),
        JapaneseTextSection(section: "Blue", textToAdd: ["Ao", "Kanji: 青", "Hiragana: あお"], expanded: false),
        JapaneseTextSection(section: "Purple", textToAdd: ["Murasaki", "Kanji: 紫", "Hiragana: むらさき"], expanded: false),
        JapaneseTextSection(section: "Brown", textToAdd: ["Cha-iro", "Kanji: 茶色", "Hiragana: ちゃいろ"], expanded: false),
        JapaneseTextSection(section: "Black", textToAdd: ["Kuro", "Kanji: 黒", "Hiragana: くろ"], expanded: false),
        JapaneseTextSection(section: "Pink", textToAdd: ["Pinku", "Hiragana: ピンク"], expanded: false),
        JapaneseTextSection(section: "Gray", textToAdd: ["Hai-iro", "Kanji: 灰色", "Hiragana: はいいろ"], expanded: false)
    ]
    
    var optionSelected : String = "None" {
        didSet {
            if(optionSelected == "Greetings"){
                arrayToDisplay = greetingSections
            }
            else if(optionSelected == "Numbers"){
                arrayToDisplay = numberSections
            }
            else{
                arrayToDisplay = colourSections
            }
        }
    }
    
    var arrayToDisplay : [JapaneseTextSection]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        print(optionSelected)
        textLabel.text = "Read \(optionSelected)"

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayToDisplay.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayToDisplay[section].textToAdd.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "reveal")!
        cell.textLabel?.text = arrayToDisplay[indexPath.section].textToAdd[indexPath.row]
        return cell
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        arrayToDisplay[section].expanded = !arrayToDisplay[section].expanded
        tableView.beginUpdates()
        for i in 0 ..< arrayToDisplay[section].textToAdd.count{
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


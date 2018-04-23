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
    
    var sections = [
        JapaneseTextSection(section: "Good Morning", textToAdd: ["Ohayō gozaimasu", "おはよう　ございます", "お早う御座います"], expanded: false),
        JapaneseTextSection(section: "Hello/Good Day", textToAdd: ["Konnichiwa", "こんにちは", "今日は"], expanded: false),
          JapaneseTextSection(section: "Good Evening", textToAdd: ["Konbanwa", "こんばんは"], expanded: false),
         JapaneseTextSection(section: "Good Night", textToAdd: ["Oyasumi nasai", "おやすみ　なさい"], expanded: false),
         JapaneseTextSection(section: "Goodbye", textToAdd: ["Sayōnara", "さようなら"], expanded: false),
         JapaneseTextSection(section: "Goodbye (Formal)", textToAdd: ["Shitsurei shimasu", "しつれい　します", "失礼します"], expanded: false)
    ]
    
    var optionSelected : String = "None"
    var attrText = """
    Good Morning: Ohayō gozaimasu

    Hello / Good Day: Konnichiwa
    
    Good evening: Konbanwa

    Good Night: Oyasumi nasai

    """
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        print(optionSelected)
        textLabel.text = "Read \(optionSelected)"

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].textToAdd.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(sections[indexPath.section].expanded){
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
        header.customInit(title: sections[section].section, section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reveal")!
        cell.textLabel?.text = sections[indexPath.section].textToAdd[indexPath.row]
        return cell
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        sections[section].expanded = !sections[section].expanded
        tableView.beginUpdates()
        for i in 0 ..< sections[section].textToAdd.count{
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


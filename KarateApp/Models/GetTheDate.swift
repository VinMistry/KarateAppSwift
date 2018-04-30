//
//  GetTheDate.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 24/01/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import Foundation

class GetTheDate {
    
    //MARK: Variables
    private let calendar = Calendar.current
    var daysTillNextClass : Int = 0
    //MARK: Functions
    
    //Formats the current date
    public func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
        let currentDateString: String = dateFormatter.string(from: date)
        return currentDateString
    }
    
 
    
    public func getAFutureDate(addDays: Int) -> String {
        let currentDate = Date()
        
        var dateComponent = DateComponents()
        
        dateComponent.day = addDays

        
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        print(currentDate)
        print(futureDate!)
        let dateForLesson = calendar.dateComponents([.year, .month, .day, .weekday], from: futureDate!)
        let day = dateForLesson.day!
        let month = dateForLesson.month!
        let year = dateForLesson.year!
        print("FUTURE DATE: \(day)-\(month)-\(year)")
        return "\(day)-\(month)-\(year)"
    }
    /*
     Using Date class and the Calendar class change the text label to present the user
     with the day the next class will take place on.
     */
    public func nextClassDate() -> String {
        let components = calendar.dateComponents([.year, .month, .day, .weekday], from: Date())
        let day = components.weekday!
        if day < 3  || day == 7 {
            print("The next lesson is: Tuesday")
            print("Days to next lesson: \(3 - day)")
            daysTillNextClass = 3-day
            return "Tuesday at 6:30pm"
        }
        else if day > 3 && day < 6 {
            print("The current day is: \(day)")
            print("The next lesson is: Friday")
            print("Days to next lesson: \(6-day)")
            daysTillNextClass = 6-day
            return "Friday at 6:45pm"
        }
        else if day == 3 || day == 6 {
            daysTillNextClass = 0
            return classToday(day: day)
        }
        else {
             return "No Class"
        }
    }
    
    //Shows the time of today's class
    private func classToday(day: Int) -> String {
        print("Today at \(stringDays(day))")
        return "Today \(stringDays(day))"
    }
    
    //Returns time at which the class takes place given the day
    private func stringDays(_ dayNumber: Int) -> String {
        switch dayNumber {
        case 3:
            return "at 6:30pm"
        case 6:
            return "at 6:45pm"
        default:
            return "No Class Today"
        }
    }
}

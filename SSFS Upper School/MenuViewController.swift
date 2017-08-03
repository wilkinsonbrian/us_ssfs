//
//  ViewController.swift
//  SSFS Lunch
//
//  Created by James Bankole on 2/28/17.
//  Copyright © 2017 James Bankole. All rights reserved.
//

//Should I make it so that if the lunch isn't up on the website, it says "lunch unavailable currently" or something?

import UIKit

class MenuViewController: UIViewController {
    
    var menu = Menu()
    
    var weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    @IBOutlet weak var lunchEntreeText: UILabel!
    
    
    
    @IBOutlet weak var vegetarianEntreeLabel: UILabel!
    
    @IBOutlet weak var vegetarianEntreeText: UILabel!
    
    
    
    
    @IBOutlet weak var sidesLabel: UILabel!
    @IBOutlet weak var sidesText: UILabel!
    
    
    @IBOutlet weak var downtownDeliLabel: UILabel!
    @IBOutlet weak var downtownDeliText: UILabel!
    
    
    
    
    func dayOfWeek() {
        var dayString = String()
        var dayBool = Bool()
        let dayOfWeek = getCurrentDay()
        if dayOfWeek! == 2 {
            dayString = "MONDAY(.*?)TUESDAY"
            dayBool = false
        } else if dayOfWeek == 3 {
            dayString = "TUESDAY(.*?)WEDNESDAY"
            dayBool = false
        } else if dayOfWeek == 4 {
            dayString = "WEDNESDAY(.*?)THURSDAY"
            dayBool = false
        } else if dayOfWeek == 5 {
            dayString = "THURSDAY(.*?)FRIDAY"
            dayBool = false
        } else if dayOfWeek == 6 {
            dayString = "FRIDAY(.*)"
            dayBool = true
        }
        // This function links the return from the getCurrentDay function to the corresponding weekday and gets the information for the day by using the words in between that day and the following. Claire Youmans created this function, I edited the if statements to correspond with my getCurrentDay function.
        let day = DailyMenu(regExText: dayString, isFriday: dayBool)
        dateLabel.text = weekdays[dayOfWeek! - 2]
        // dayOfWeek starts at 2 (becuase Monday is returned as Optional(2) in the getCurrentDay function. So to make it correspond with the weekdays variable, there is a "- 2" so that the weekdays align.
        lunchEntreeText.text = day.lunchEntree
        vegetarianEntreeText.text = day.vegetarianEntree
        sidesText.text = day.sides
        downtownDeliText.text = day.downtownDeli
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayOfWeek()
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
       
    }
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AfterSchoolViewController")
            self.present(vc, animated: false, completion: nil)
        }
    }
    func getCurrentDay()->Int?{
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .weekday], from: date)
        let day = components.weekday
        
        return day
        // code from http://stackoverflow.com/questions/28861091/getting-the-current-day-of-the-week-in-swift .This function gets the current day of the week and returns it as Optional() with the corresponding number for the day of the week it is. For example Optional(2) is Monday and Optional(1) is Sunday.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


//
//  AfterSchoolViewController.swift
//  SSFS Upper School
//
//  Created by james on 4/12/17.
//  Copyright © 2017 james. All rights reserved.
//

import UIKit

class AfterSchoolViewController: UIViewController {
    let afterSchool = AfterS()
    var weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var gamesTodayText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let activities = afterSchool.getGames(dayOfWeek: getCurrentDay()!)
        gamesTodayText.text = activities
        dayOfWeek()
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        // Do any additional setup after loading the view. The "let activities" sends the date to the getGames function in my after school file, and then runs it in this file.
    }
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LibraryViewController")
            self.present(vc, animated: false, completion: nil)
        }
        else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MenuViewController")
            self.present(vc, animated: false, completion: nil)
        }
    }
    func dayOfWeek() {
        let dayOfWeek = getCurrentDate()
        dateLabel.text = weekdays[dayOfWeek! - 2]
        // pasted into here to get day of the week at the top of the screen (See MenuViewController)
    }
    func getCurrentDate()->Int?{
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .weekday], from: date)
        let day = components.weekday
        // pasted into here to get day of the week at the top of the screen (See MenuViewController)
        
        return day
        // code from http://stackoverflow.com/questions/28861091/getting-the-current-day-of-the-week-in-swift . This code gets the day of the current date as an integer (Unlike code in menu view controller, this returns the date instead of the day of week).
    }
    func getCurrentDay()->Int?{
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let day = components.day
        // pasted into here to get day of the week at the top of the screen (See MenuViewController)
        
        return day
        // code from http://stackoverflow.com/questions/28861091/getting-the-current-day-of-the-week-in-swift . This code gets the day of the current date as an integer (Unlike code in menu view controller, this returns the date instead of the day of week).
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

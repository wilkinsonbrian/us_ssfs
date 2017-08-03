//
//  DailyMenu.swift
//  SSFS Lunch
//
//  Created by Claire Youmans on 5/17/16.
//  Copyright © 2016 Claire Youmans. All rights reserved.
//

import Foundation
class DailyMenu {
    var lunchEntree = String()
    var vegetarianEntree = String()
    var sides = String()
    var downtownDeli = String()
    var dayMeal: String
    var fridayMeal: String
    
    var menu = Menu()

    init(regExText: String, isFriday: Bool) {
        if isFriday == false {
            self.dayMeal = String(menu.getLunch(stringToParse: menu.aMenu, regExText: regExText))
            self.fridayMeal = String("") //Have to set self.fridayMeal as something, otherwise error.
            getDailyMeal()
        }
        else {
            self.fridayMeal = String(menu.getLunch(stringToParse: menu.aMenu, regExText: regExText))
            self.dayMeal = String(menu.getLunch(stringToParse: fridayMeal, regExText: regExText)) //Every other weekday is mentioned only once in the xml file, so because Friday is mentioned twice it grabs the first Friday the first time (which is the wrong one). This runs it twice, so that the first Friday is cut out the first time, and the correct Friday is grabbed the second time.
            getDailyMeal()
        }

    }
    
    func getDailyMeal() {
        lunchEntree = String(menu.getLunch(stringToParse: dayMeal, regExText: "LUNCH ENTRÉE(.*?)VEGETARIAN"))
        vegetarianEntree = String(menu.getLunch(stringToParse: dayMeal, regExText: "VEGETARIAN ENTRÉE(.*?)SIDES"))
        sides = String(menu.getLunch(stringToParse: dayMeal, regExText: "SIDES(.*?)DOWNTOWN"))
        downtownDeli = String(menu.getLunch(stringToParse: dayMeal, regExText: "DOWNTOWN DELI(.*?)DINNER"))
    }
}

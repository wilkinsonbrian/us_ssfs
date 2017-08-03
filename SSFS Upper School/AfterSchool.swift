//
//  AfterSchool.swift
//  SSFS Upper School
//
//  Created by james on 4/11/17.
//  Copyright © 2017 james. All rights reserved.
//

import Foundation
class AfterS {
    var activity = String()
    var time = String()
    
    
    init(){
        if let url = URL(string: "http://www.ssfs.org/athletics/athletics-today") {
            do {
                self.activity = try String(contentsOf: url)
            } catch {
                print("There was an error.")
                // This gives activity the web contents of the url's webpage.
            }
            
        }
    }
    
    func getGames(dayOfWeek: Int) -> String {
        let regExText =  "\"fsDay\">\(dayOfWeek)<(.*?)a>"
        let name = processRegEx(regExText: regExText, searchText: activity)
        let regExTextTwo = "href=\"#\">(.*?)</"
        let game = processRegEx(regExText: regExTextTwo, searchText: name)
        return game
        // This function contains the search string.
    }
}
    func processRegEx(regExText: String, searchText:String) -> String {
        var name: String = ""
        var returnGames: String = ""
        if let range = searchText.range(of:regExText) {
            name = searchText.substring(with:range)
        }
        do {
            let regex = try NSRegularExpression(pattern: regExText, options: NSRegularExpression.Options.dotMatchesLineSeparators)
            let matches = regex.matches(in: searchText as String, options: [], range: NSMakeRange(0, searchText.characters.count))
            for match in matches{
                name = (searchText as NSString).substring(with: match.rangeAt(1))
                returnGames += "\n" + name + "\n"
                
            }
                
                // These lines of code isolate the data that I intend to pull from the url. The function, getGames, uses a regular expression, regExText, and takes a small portion of info from the page source by identifying where the date of each event is. It calls the dayOfWeek variable to find all portions of information that correspond with the current date. It then sets that equal to name. The next regular expression, regExTwo, takes that portion of information from name and then pulls the title of the event from it. I am now trying to get the processRegEx function to do it for each event, I am currently unsuccessful.
            
        } catch {
        }
        return returnGames
    }
    



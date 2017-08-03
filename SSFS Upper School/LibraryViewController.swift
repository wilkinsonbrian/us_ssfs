//
//  LibraryViewController.swift
//  SSFS Upper School
//
//  Created by james on 5/3/17.
//  Copyright © 2017 james. All rights reserved.
//

import GoogleAPIClientForREST
import GoogleSignIn
import UIKit

class LibraryViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    
    // If modifying these scopes, delete your previously saved credentials by
    // resetting the iOS simulator or uninstall the app.
    private let scopes = [kGTLRAuthScopeSheetsSpreadsheetsReadonly]
    
    private let service = GTLRSheetsService()
    let signInButton = GIDSignInButton()
    let output = UITextView()
    
    @IBOutlet weak var libraryTimes: UILabel!
    @IBOutlet weak var beestroTimes: UILabel!
    @IBOutlet weak var outages: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(sender:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        GIDSignIn.sharedInstance().signInSilently()
        
        // Add the sign-in button.
        view.addSubview(signInButton)
        
        // Add a UITextView to display output.
//        output.frame = view.bounds
//        output.isEditable = false
//        output.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
//        output.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        output.isHidden = true
//        view.addSubview(output);
    }
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .right) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AfterSchoolViewController")
            self.present(vc, animated: false, completion: nil)
        }
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            showAlert(title: "Authentication Error", message: error.localizedDescription)
            self.service.authorizer = nil
        } else {
            self.signInButton.isHidden = true
            self.output.isHidden = false
            self.service.authorizer = user.authentication.fetcherAuthorizer()
            listMajors()
        }
    }
    
    // Display (in the UITextView) the names and majors of students in a sample
    // spreadsheet:
    // https://docs.google.com/spreadsheets/d/1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms/edit
    func listMajors() {
        libraryTimes.text = "Getting sheet data..."
        beestroTimes.text = "Getting sheet data..."
        outages.text = "Getting sheet data..."
        let spreadsheetId = "1Fk3XgNwrD51I4sPy-vsBkc0o2HrKewiuiiP4siE3s3k"
        let range = "Sheet1!A2:I20"
        let query = GTLRSheetsQuery_SpreadsheetsValuesGet
            .query(withSpreadsheetId: spreadsheetId, range:range)
        service.executeQuery(query,
                             delegate: self,
                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:))
        )
    }
    
    // Process the response and display output
    func displayResultWithTicket(ticket: GTLRServiceTicket,
                                 finishedWithObject result : GTLRSheets_ValueRange,
                                 error : NSError?) {
        
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }
        
        var libraryString = ""
        var beestroString = ""
        var outagesString = ""
        let rows = result.values!
        
        if rows.isEmpty {
            libraryTimes.text = "No data found."
            return
        }
        if rows.isEmpty {
            beestroTimes.text = "No data found."
            return
        }
        if rows.isEmpty {
            outages.text = "No data found."
            return
        }
        
        libraryString += "Library Hours:\n"
        beestroString += "Beestro Hours:\n"
        outagesString += "Beestro Outages: \n"
        for row in rows {
            let libraryDate = row[0]
            let libraryOpening = row[4]
            let beestroDate = row[0]
            let beestroOpening = row[6]
            let outagesOpening = row[7]
            
            libraryString += "\(libraryDate), \(libraryOpening)\n"
            beestroString += "\(beestroDate), \(beestroOpening)\n"
            outagesString += "\(outagesOpening)\n"
        }
        
        libraryTimes.text = libraryString
        beestroTimes.text = beestroString
        outages.text = outagesString
    }
    
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
// code from https://developers.google.com/sheets/api/quickstart/ios?ver=swift

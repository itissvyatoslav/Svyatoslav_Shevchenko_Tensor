//
//  TimeViewController.swift
//  ShevchenkoMenu
//
//  Created by user on 02/12/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import UserNotifications

class TimeViewController: UIViewController{
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        setView()
        setDatePicker()
        setButton()
    }
    
    func setView(){
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "Set Time"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setDatePicker(){
        datePicker.datePickerMode = .time
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
    }
    
    func setButton(){
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addTime))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func createNotification(){
        
        for indexPush in 0..<scheduledTime.count{
             removeNotifications(withIdentifiers: ["CookPush\(indexPush - 1)"])
            let content = UNMutableNotificationContent()
            content.title = "👩‍🍳 It's time to cook! "
            content.subtitle = timeNames[indexPush]
            content.body = "You have an hour before eating"
            content.sound = UNNotificationSound.default
            
            var date = DateComponents()
            let currentHour = Calendar.current.component(.hour, from: scheduledTime[indexPush])
            let currentMinute = Calendar.current.component(.minute, from: scheduledTime[indexPush])
            if currentHour == 0 {
                date.hour = 23
            } else {
                date.hour = currentHour - 1
            }
            date.minute = currentMinute
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            
            let request = UNNotificationRequest(identifier: "CookPush\(indexPush)", content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request)
        }
    }
    
    func removeNotifications(withIdentifiers identifiers: [String]){
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
    @objc func addTime(){
        addTimeToSchedule(time: datePicker!.date, name: nameTextField.text ?? "")
        self.navigationController?.popViewController(animated: true)
        createNotification()
    }
    
    func configureViews(){
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureConstraints(){
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            datePicker.leftAnchor.constraint(equalTo: view.leftAnchor),
            datePicker.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 15),
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),

            nameTextField.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 15),
            nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 10),
            nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),

        ])
        
        
    }
}

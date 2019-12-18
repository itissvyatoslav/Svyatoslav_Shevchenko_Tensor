//
//  ScheduleViewController.swift
//  ShevchenkoMenu
//
//  Created by user on 29/11/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

let idCell = "ScheduleCell"

class ScheduleViewController: UIViewController{
  
    @IBOutlet weak var addTimeButton: UIBarButtonItem!
    @IBOutlet weak var schedule: UITableView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setSchedule()
        setButton()
        configureViews()
        configureConstraints()    
    }
    
    func setSchedule(){
        schedule.dataSource = self
        schedule.delegate = self
        
        self.view.backgroundColor = UIColor.white
        schedule.rowHeight = 60
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setButton(){
        let addTimeButton = UIBarButtonItem(title: "Add time", style: .plain, target: self, action: #selector(goToAddTime))
        navigationItem.rightBarButtonItem = addTimeButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        schedule.reloadData()
    }
    
    @objc func goToAddTime(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "TimeViewController") as! TimeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureViews(){
        schedule.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureConstraints(){
        NSLayoutConstraint.activate([
        schedule.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        schedule.topAnchor.constraint(equalTo: view.topAnchor),
        schedule.leftAnchor.constraint(equalTo: view.leftAnchor),
        schedule.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return true
       }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeTime(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}


extension ScheduleViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduledTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .value1, reuseIdentifier: idCell)
        
        cell.textLabel?.text = getDate(scheduledTime[indexPath.row])
        cell.detailTextLabel?.text = timeNames[indexPath.row]
        return cell
    }
    
    func getDate(_ date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}





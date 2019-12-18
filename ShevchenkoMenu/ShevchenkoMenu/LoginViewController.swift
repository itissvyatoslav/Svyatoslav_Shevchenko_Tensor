//
//  LoginViewController.swift
//  ShevchenkoMenu
//
//  Created by user on 22/11/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import UserNotifications

class LoginViewController: UIViewController {
    @IBOutlet private var greetingLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = nil
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    private func configureViews(){
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        goButton.translatesAutoresizingMaskIntoConstraints = false
        timeButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func configureConstraints(){
        NSLayoutConstraint.activate([
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
            
            timeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 250),
            
            
        ])
    }
    
    func onGoTapped(_ sender: Any){
        performSegue(withIdentifier: "Register", sender: self)
    }
    
    
}

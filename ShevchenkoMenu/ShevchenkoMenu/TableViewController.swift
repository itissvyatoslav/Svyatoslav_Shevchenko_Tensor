//
//  TableViewController.swift
//  ShevchenkoMenu
//
//  Created by user on 27/11/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let timePicker = UIDatePicker()

   
    @IBOutlet weak var pushAddTime: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pushAddTime.target = timePicker

    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
}

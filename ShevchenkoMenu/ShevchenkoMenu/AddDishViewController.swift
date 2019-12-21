//
//  AddDishViewController.swift
//  ShevchenkoMenu
//
//  Created by user on 09/12/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class AddDishViewController: UIViewController{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: UITextView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var recipeView: UITextView!
    @IBOutlet weak var recipeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        if selectedIndex == nil {
            self.navigationItem.title = "New Dish"
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addDish))
            navigationItem.rightBarButtonItem = doneButton
        } else if menuIsFiltered == false {
            setSave()
            nameField.text = menu[selectedIndex!].name
            recipeView.text = menu[selectedIndex!].recipe
            typeSegmentedControl.selectedSegmentIndex = menu[selectedIndex!].type
            
        } else {
            setSave()
            nameField.text = filteredMenu[selectedIndex!].name
            recipeView.text = filteredMenu[selectedIndex!].recipe
            typeSegmentedControl.selectedSegmentIndex = filteredMenu[selectedIndex!].type
        }
        
        configureViews()
        configureConstraints()

    }
    
    func setSave(){
        self.navigationItem.title = "Edit Dish"
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveDish))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveDish(){
        let editedName = setUpNewDish(nameField.text)
        let editedType = typeSegmentedControl.selectedSegmentIndex
        let editedRecipe = setUpNewDish(recipeView.text)
        dishNames[selectedIndex!] = editedName
        dishTypes[selectedIndex!] = editedType
        dishRecipes[selectedIndex!] = editedRecipe
        saveData()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addDish(){
       
        let nameOfNewDish = setUpNewDish(nameField.text)
        let typeOfNewDish = typeSegmentedControl.selectedSegmentIndex
        let recipeOfNewDish = setUpNewDish(recipeView.text)
        addDishToMenu(nameOfNewDish, typeOfNewDish, recipeOfNewDish)
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureViews(){
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameField.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        recipeView.translatesAutoresizingMaskIntoConstraints = false
        recipeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureConstraints(){
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            
            typeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            typeLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: 40),
            
            recipeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            recipeLabel.centerYAnchor.constraint(equalTo: typeLabel.centerYAnchor, constant: 40),
            
            nameField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 30),
            nameField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            nameField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),

            typeSegmentedControl.centerYAnchor.constraint(equalTo: typeLabel.centerYAnchor),
            typeSegmentedControl.leftAnchor.constraint(equalTo: typeLabel.rightAnchor, constant: 30),
            typeSegmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            
            recipeView.topAnchor.constraint(equalTo: recipeLabel.bottomAnchor, constant: 3),
            recipeView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            recipeView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            recipeView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
        ])
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            recipeView.contentInset = .zero
        } else {
            recipeView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        recipeView.scrollIndicatorInsets = recipeView.contentInset
        
        let selectedRange = recipeView.selectedRange
        recipeView.scrollRangeToVisible(selectedRange)
    }
    
   
    func setUpNewDish(_ stringName: String) -> String{
        if stringName == ""{
            return "New Dish"
        } else {
            return stringName
        }
    
    }
    
}

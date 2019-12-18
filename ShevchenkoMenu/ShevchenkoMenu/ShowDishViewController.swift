//
//  ShowDishViewController.swift
//  ShevchenkoMenu
//
//  Created by user on 09/12/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class ShowDishViewController: UIViewController{
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var recipeField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeField.isEditable = false
        ShowDish(selectedIndex!)
        configureViews()
        configureConstraints()
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editDish))
        navigationItem.rightBarButtonItem = editButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ShowDish(selectedIndex!)
        super.viewWillAppear(animated)
    }
    
    @objc func editDish(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddDishViewController") as! AddDishViewController
               self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func ShowDish(_ indexDish: Int){
        if menuIsFiltered == true{
            nameLabel.text = filteredMenu[indexDish].name
            typeLabel.text = NameTypeOfDish(typeRaw: filteredMenu[indexDish].type)
            recipeField.text = filteredMenu[indexDish].recipe
        } else {
            nameLabel.text = menu[indexDish].name
            typeLabel.text = NameTypeOfDish(typeRaw: menu[indexDish].type)
            recipeField.text = menu[indexDish].recipe
        }
    }
    
    func configureViews(){
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureConstraints(){
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            typeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            
            recipeField.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 30),
            recipeField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            recipeField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            recipeField.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        let fixedWidth = nameLabel.frame.size.width
        let newSize = nameLabel.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        nameLabel.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
    }
}

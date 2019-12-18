//
//  MenuTableViewController.swift
//  ShevchenkoMenu
//
//  Created by user on 02/12/2019.
//  Copyright © 2019 user. All rights reserved.
//
import Foundation
import UIKit

class MenuTableViewController: UIViewController{
    @IBOutlet weak var dishes: UITableView!
    private let search = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = search.searchBar.text else {return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        let searchBarScopeIsFiltering = search.searchBar.selectedScopeButtonIndex != 0
        if search.isActive && (!searchBarIsEmpty || searchBarScopeIsFiltering) {
            menuIsFiltered = true
        } else {
            menuIsFiltered = false
        }
        return menuIsFiltered
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTable()
        setButtons()
        setSearcher()
        
    }
    
    func setTable() {
        dishes.dataSource = self
        dishes.delegate = self
        self.view.backgroundColor = UIColor.white
        dishes.rowHeight = 70
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setButtons() {
        let addTimeButton = UIBarButtonItem(title: "Add dish", style: .plain, target: self, action: #selector(goToAddDish))
        let randomTimeButton = UIBarButtonItem(title: "Random", style: .plain, target: self, action: #selector(goToRandomDish))
        navigationItem.rightBarButtonItems = [addTimeButton, randomTimeButton]
    }
    
    func setSearcher() {
       
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search"
        navigationItem.searchController = search
        definesPresentationContext = true
        
        search.searchBar.scopeButtonTitles = ["All", "Breakfast", "Lunch", "Dinner"]
        search.searchBar.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        selectedIndex = nil
        super.viewWillAppear(animated)
        dishes.reloadData()
    }
    
    @objc func goToAddDish(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddDishViewController") as! AddDishViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func goToRandomDish(){
        if menu.count == 0 {
            NoDishesError()
        } else {
            selectedIndex = Int.random(in: 0..<dishNames.count)
            let vc = storyboard?.instantiateViewController(withIdentifier: "ShowDishViewController") as! ShowDishViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func NoDishesError() {
        let alertController = UIAlertController(
            title: "No dishes",
            message: "We can't show you any random dish☹️",
            preferredStyle: .alert)

        alertController.addAction(UIAlertAction(
            title: "Close",
            style: .default,
            handler: { _ in
                alertController.dismiss(animated: true, completion: nil)
        }))

        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeDish(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}

extension MenuTableViewController: UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering{
            return filteredMenu.count
        }
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "MenuCellId")
        var dish: dishType
        if isFiltering{
            dish = filteredMenu[indexPath.row]
        } else {
            dish = menu[indexPath.row]
        }
        cell.textLabel?.text = dish.name
        cell.detailTextLabel?.text = "\(NameTypeOfDish(typeRaw: dish.type))"
        return cell
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        let vc = storyboard?.instantiateViewController(withIdentifier: "ShowDishViewController") as! ShowDishViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All"){
        filteredMenu = menu.filter({ (dish: dishType) -> Bool in
            let doesCategoryMatch = (scope == "All") || NameTypeOfDish(typeRaw: dish.type) == scope
            
            if searchBarIsEmpty{
                return doesCategoryMatch
            }
            return doesCategoryMatch && dish.name.lowercased().contains(searchText.lowercased())
        })
    
        dishes.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
    
    

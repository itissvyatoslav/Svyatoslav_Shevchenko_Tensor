//
//  Model.swift
//  ShevchenkoMenu
//
//  Created by user on 27/11/2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

struct dishType {
    var name: String
    var type: Int
    var recipe: String
}

var menu = [dishType]()
var filteredMenu = [dishType]()
var menuIsFiltered = false
var selectedIndex: Int?

var scheduledTime = [Date]()
let keySchedule = "keySchedule"

var timeNames = [String]()
let keyTimeNames = "keyTimeNames"

var dishNames = [String]()
let keyDishNames = "keyDishNames"

var dishTypes = [Int]()
let keyDishTypes = "keyDishTypes"

var dishRecipes = [String]()
let keyDishRecipes = "keyDishRecipes"

func addTimeToSchedule(time: Date, name: String){
    scheduledTime.append(time)
    timeNames.append(name)
    saveData()
}

func removeTime(at index: Int){
    scheduledTime.remove(at: index)
    timeNames.remove(at: index)
    saveData()
}

func addDishToMenu(_ newName: String, _ newType: Int, _ newRecipe: String){
    dishNames.append(newName)
    dishTypes.append(newType)
    dishRecipes.append(newRecipe)
    saveData()
}

func removeDish(at indexOfRemoving: Int){
    dishNames.remove(at: indexOfRemoving)
    dishTypes.remove(at: indexOfRemoving)
    dishRecipes.remove(at: indexOfRemoving)
    saveData()
}

func NameTypeOfDish(typeRaw: Int) -> String{
    switch typeRaw {
    case 0:
        return "Breakfast"
    case 1:
        return "Lunch"
    case 2:
        return "Dinner"
    default:
        return "Oops"
    }
}

func saveData(){
    UserDefaults.standard.set(scheduledTime, forKey: keySchedule)
    UserDefaults.standard.set(timeNames, forKey: keyTimeNames)
    UserDefaults.standard.set(dishNames, forKey: keyDishNames)
    UserDefaults.standard.set(dishTypes, forKey: keyDishTypes)
    UserDefaults.standard.set(dishRecipes, forKey: keyDishRecipes)
    UserDefaults.standard.synchronize()
    setUpMenu()
    print("Data is saved")
    
}

func loadData(){
    if let loadedSchedule = UserDefaults.standard.array(forKey: keySchedule) as? [Date]{
        scheduledTime = loadedSchedule
    } else {
        scheduledTime = []
    }
    if let loadedSchedule = UserDefaults.standard.array(forKey: keyTimeNames) as? [String]{
        timeNames = loadedSchedule
    } else {
        timeNames = []
    }
    if let loadedSchedule = UserDefaults.standard.array(forKey: keyDishNames) as? [String]{
        dishNames = loadedSchedule
    } else {
        dishNames = []
    }
    if let loadedSchedule = UserDefaults.standard.array(forKey: keyDishTypes) as? [Int]{
        dishTypes = loadedSchedule
    } else {
        dishTypes = []
    }
    if let loadedSchedule = UserDefaults.standard.array(forKey: keyDishRecipes) as? [String]{
        dishRecipes = loadedSchedule
    } else {
        dishRecipes = []
    }
    
    setUpMenu()
    
}

func setUpMenu() {
    menu = []
    for index in 0..<dishNames.count{
        let newDish = dishType(name: dishNames[index], type: dishTypes[index], recipe: dishRecipes[index])
        menu.append(newDish)
    }
}





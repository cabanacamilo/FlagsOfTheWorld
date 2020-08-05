//
//  ViewController.swift
//  FlagsOfTheWorld
//
//  Created by Camilo Cabana on 3/08/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import UIKit

class FlagsController: UITableViewController {
    
    var flags: [Flag] = [
        Flag(flag: "🇦🇺", country: "Australia", region: "Oceania", population: "24.13m"),
        Flag(flag: "🇳🇿", country: "New Zealand", region: "Oceania", population: "4.69m"),
        Flag(flag: "🇨🇦", country: "Canada", region: "North America", population: "36.3m"),
        Flag(flag: "🇳🇴", country: "Norway", region: "Scandinavia", population: "3.8m"),
        Flag(flag: "🇸🇧", country: "Solomon Islands", region: "Micronesia", population: "611k"),
        Flag(flag: "🇮🇳", country: "India", region: "South Asia", population: "1.324b"),
        Flag(flag: "🇨🇳", country: "China", region: "East Asia", population: "1.379b"),
        Flag(flag: "🇬🇲", country: "Gambia", region: "West Africa", population: "2.039m"),
        Flag(flag: "🇨🇱", country: "Chile", region: "South America", population: "17.91m"),
        Flag(flag: "🇨🇴", country: "Colombia", region: "South America", population: "48.65m"),
        Flag(flag: "🇩🇪", country: "Germany", region: "Europe", population: "82.67m"),
        Flag(flag: "🇬🇹", country: "Guatemala", region: "Central America", population: "16.58m"),
        Flag(flag: "🇬🇾", country: "Guyana", region: "South America", population: "773k"),
        Flag(flag: "🇦🇪", country: "United Arab Emirates", region: "Western Asia", population: "9.4m"),
        Flag(flag: "🇦🇱", country: "Albania", region: "Balkan Peninsula", population: "2.873m"),
        Flag(flag: "🇪🇹", country: "Ethiopia", region: "Horn of Africa", population: "105m"),
        Flag(flag: "🇦🇪", country: "Greece", region: "South Eastern Europe", population: "10.77m"),
        Flag(flag: "🇰🇬", country: "Kyrgyzstan", region: "Central Asia", population: "6.2m")
    ]
    let cellID = "FlagCell"
    
    lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editingFlag))
        return button
    }()
    
    lazy var addButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToEditAndAdd))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setNavigationBar()
    }
    
    func setNavigationBar() {
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = editButton
        navigationItem.rightBarButtonItem = addButton
    }
    
    func setTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        view.backgroundColor = .white
        tableView.register(UINib(nibName: "FlagTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FlagTableViewCell
        let flag = flags[indexPath.row]
        cell.configure(flag: flag)
        cell.showsReorderControl = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        configuratePush(title: "Edit", index: indexPath, flag: flags[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedFlag = flags.remove(at: sourceIndexPath.row)
        flags.insert(movedFlag, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            flags.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func editingFlag(_ sender: UIBarButtonItem) {
        let editingMode = tableView.isEditing
        tableView.setEditing(!editingMode, animated: true)
    }
    
    @objc func goToEditAndAdd(_ sender: UIBarButtonItem) {
        configuratePush(title: "Add", index: nil, flag: nil)
    }
    
    func configuratePush(title: String, index: IndexPath?, flag: Flag?) {
        let editAndAdd = EditAndAddController()
        editAndAdd.navigationItem.title = title
        editAndAdd.flagsController = self
        editAndAdd.index = index
        editAndAdd.flag = flag
        navigationController?.pushViewController(editAndAdd, animated: true)
    }
    
    func saveData(index: IndexPath?, flag: Flag) {
        if index != nil {
            flags[index?.row ?? Int()] = flag
        } else {
            flags.append(flag)
        }
        tableView.reloadData()
    }
}

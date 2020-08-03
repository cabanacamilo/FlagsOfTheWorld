//
//  EditAndAddController.swift
//  FlagsOfTheWorld
//
//  Created by Camilo Cabana on 3/08/20.
//  Copyright © 2020 Camilo Cabana. All rights reserved.
//

import UIKit

class EditAndAddController: UITableViewController {
    var flagCell = UITableViewCell()
    var countryCell = UITableViewCell()
    var regionCell = UITableViewCell()
    var populationCell = UITableViewCell()
    var flagTextField = UITextField()
    var countryTextField = UITextField()
    var regionTextField = UITextField()
    var populationTexField = UITextField()
    var flag: Flag?
    var index: IndexPath?
    weak var flagsController: FlagsController?
    
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveInformationFlag))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let flag = self.flag {
            self.flagTextField.text = flag.flag
            self.countryTextField.text = flag.country
            self.regionTextField.text = flag.region
            self.populationTexField.text = flag.population
        }
        navigationItem.rightBarButtonItem = saveButton
        setTextFields()
        updateSaveButtonState()
    }
    
    func setTextFields() {
        flagTextField.addTarget(self, action: #selector(textEditingChange), for: .editingChanged)
        countryTextField.addTarget(self, action: #selector(textEditingChange), for: .editingChanged)
        regionTextField.addTarget(self, action: #selector(textEditingChange), for: .editingChanged)
        populationTexField.addTarget(self, action: #selector(textEditingChange), for: .editingChanged)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return 1
        case 1: return 1
        case 2: return 1
        case 3: return 1
        default: fatalError("Unknown number of sections")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0: return self.flagCell
            default: fatalError("Unknown row in section 0")
            }
        case 1:
            switch (indexPath.row) {
            case 0: return self.countryCell
            default: fatalError("Unknown row in section 1")
            }
        case 2:
            switch (indexPath.row) {
            case 0: return self.regionCell
            default: fatalError("Unknown row in section 2")
            }
        case 3:
            switch (indexPath.row) {
            case 0: return self .populationCell
            default: fatalError("Unknown row in section 3")
            }
        default: fatalError("Unknown section")
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0: return "Flag"
        case 1: return "Country"
        case 2: return "Region"
        case 3: return "Population"
        default: fatalError("Unknown section")
        }
    }
    
    override func loadView() {
        super.loadView()
        tableView = UITableView(frame: .zero, style: .grouped)
        flagTextField = UITextField(frame: flagCell.contentView.bounds.insetBy(dx: 15, dy: 0))
        flagTextField.placeholder = "Flag"
        flagCell.addSubview(flagTextField)
        countryTextField = UITextField(frame: countryCell.contentView.bounds.insetBy(dx: 15, dy: 0))
        countryTextField.placeholder = "Country"
        countryCell.addSubview(countryTextField)
        regionTextField = UITextField(frame: regionCell.contentView.bounds.insetBy(dx: 15, dy: 0))
        regionTextField.placeholder = "Region"
        regionCell.addSubview(regionTextField)
        populationTexField = UITextField(frame: populationCell.contentView.bounds.insetBy(dx: 15, dy: 0))
        populationTexField.placeholder = "Population"
        populationCell.addSubview(populationTexField)
    }
    
    func updateSaveButtonState() {
        let flagText = flagTextField.text ?? ""
        let countryText = countryTextField.text ?? ""
        let regionText = regionTextField.text ?? ""
        let populationText = populationTexField.text ?? ""
        saveButton.isEnabled = !flagText.isEmpty && !countryText.isEmpty && !regionText.isEmpty && !populationText.isEmpty
    }
    
    @objc func textEditingChange(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @objc func saveInformationFlag() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true) {
            let flagText = self.flagTextField.text ?? ""
            let countryText = self.countryTextField.text ?? ""
            let regionText = self.regionTextField.text ?? ""
            let populationText = self.populationTexField.text ?? ""
            let flag = Flag(flag: flagText, country: countryText, region: regionText, population: populationText)
            self.flagsController?.saveData(index: self.index, flag: flag)
        }
    }
}

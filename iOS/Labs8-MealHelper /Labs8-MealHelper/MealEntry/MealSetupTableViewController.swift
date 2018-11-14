//
//  MealSetupTableViewController.swift
//  Labs8-MealHelper
//
//  Created by De MicheliStefano on 13.11.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit

class MealSetupTableViewController: UITableViewController {
    
    // MARK: - Public properties
    
    
    
    // MARK: - Private properties

    lazy private var saveBarButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MealSetupTableViewCell.self, forCellReuseIdentifier: "MealSetup")
        
        // Header view
        //tableView.tableHeaderView = UIImageView(image: UIImage(named: "weatherTest"))
        let mealSetupHeaderView = MealSetupHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 100.0))
        tableView.tableHeaderView = mealSetupHeaderView
        
        // Footer view
        let mealSetupFooterView = MealSetupFooterView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 400.0))
        tableView.tableFooterView = mealSetupFooterView
        
        setupViews()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealSetup", for: indexPath) as! MealSetupTableViewCell

        cell.backgroundColor = UIColor.lightGray
        
        return cell
    }
    
    // MARK: - Public methods
    
    @objc func save() {
        print("saved")
    }
    
    // MARK: - Configuration
    
    private func setupViews() {
        // tableView.tableHeaderView // metrics view
        title = "Add meal"
        navigationItem.setRightBarButton(saveBarButton, animated: true)
        
        tableView.allowsSelection = false
    }

    
}

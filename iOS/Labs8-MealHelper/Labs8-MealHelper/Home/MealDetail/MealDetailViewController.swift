//
//  MealDetailViewController.swift
//  Labs8-MealHelper
//
//  Created by Simon Elhoej Steinmejer on 30/11/18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit

class MealDetailViewController: UIViewController {
    
    var meal: Meal? {
        didSet {
            navigationItem.title = meal?.mealTime
            fetchIngredients()
        }
    }
    
    var ingredients: [Ingredient]? {
        didSet {
            ingredientsTableView.ingredients = ingredients
        }
    }
    
    let nutrientsView: NutrientsView = {
        let view = NutrientsView()
        view.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    let ingredientsTableView: IngredientTableViewController = {
        let tvc = IngredientTableViewController()
        tvc.tableView.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        tvc.tableView.layer.cornerRadius = 12
        
        return tvc
    }()
    
    let weatherView: WeatherView = {
        let wv = WeatherView()
        wv.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        wv.layer.cornerRadius = 12
        
        return wv
    }()
    
    let noteView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    let backgroundImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "mountain"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let blurEffect: UIVisualEffectView = {
        let frost = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        frost.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return frost
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        view.setGradientBackground(colorOne: UIColor.nightSkyBlue.cgColor, colorTwo: UIColor.mountainDark.cgColor, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0.8, y: 0.3))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(backgroundImageView)
        backgroundImageView.fillSuperview()
        
        view.addSubview(blurEffect)
        blurEffect.fillSuperview()
        
        view.addSubview(nutrientsView)
        nutrientsView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 30, bottom: 0, right: 30), size: CGSize(width: 0, height: 80))
        
        view.addSubview(ingredientsTableView.tableView)
        ingredientsTableView.tableView.anchor(top: nutrientsView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 30, bottom: 0, right: 30), size: CGSize(width: 0, height: 200))
        
        view.addSubview(weatherView)
        weatherView.anchor(top: ingredientsTableView.tableView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 30, bottom: 0, right: 30), size: CGSize(width: 0, height: 130))
        
        view.addSubview(noteView)
        noteView.anchor(top: weatherView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 30, bottom: 0, right: 30), size: CGSize(width: 0, height: 100))
    }
    
    private func fetchIngredients() {
        guard let meal = meal, let recipeId = meal.recipeId else { return }
        FoodClient.shared.fetchIngredients(withRecipeId: recipeId) { (response) in
            DispatchQueue.main.async {
                switch response {
                case .success(let ingredients):
                    self.ingredients = ingredients
                    self.fetchNutrients()
                case .error(let error):
                    NSLog("Error fetching ingredients: \(error)")
                    self.showAlert(with: "Could not fetch ingredients.")
                }
            }
        }
    }
    
    private func fetchNutrients() {
        guard let ingredients = ingredients else { return }
        
        for ingredient in ingredients {
            guard let ingredientId = ingredient.identifier else { return }
            FoodClient.shared.fetchNutrients(withIngredientId: ingredientId) { (response) in
                DispatchQueue.main.async {
                    switch response {
                    case .success(let nutrients):
                        var updatedIngredient = ingredient
                        updatedIngredient.nutrients = nutrients
                        guard let index = self.ingredients?.index(of: updatedIngredient) else { return }
                        self.ingredients?.remove(at: index)
                        self.ingredients?.insert(updatedIngredient, at: index)
                    case .error(let error):
                        NSLog("Error fetching nutrients: \(error)")
                    }
                }
            }
        }
    }

}

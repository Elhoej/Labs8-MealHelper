//
//  IngredientDetailViewController.swift
//  Labs8-MealHelper
//
//  Created by De MicheliStefano on 14.11.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import Foundation
import UIKit

class IngredientDetailViewController: UIViewController {
    
    // MARK: - Public properties
    
    var delegate: IngredientsTableViewController?
    var delegateIndexPath: IndexPath?
    
    // MARK: - Private properties
    
    private let ingredientSummaryView = FoodSummaryView()
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8.0
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to basket", for: .normal)
        button.addTarget(self, action: #selector(addToBasket), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - User actions
    
    @objc private func addToBasket() {
        // Add to basket
        
        // When user taps on addToBasket then we tell the delegate VC to select and highlight the appropriate row
        dismiss(animated: true) {
            if let indexPath = self.delegateIndexPath {
                self.delegate?.selectFood(at: indexPath)
            }
        }
    }
    
    // MARK: - Configuration
    
    private func setupViews() {
        view.addSubview(containerView)
        containerView.addSubview(ingredientSummaryView)
        containerView.addSubview(addButton)
        
        containerView.centerInSuperview(size: CGSize(width: view.bounds.width * 0.9, height: view.bounds.height * 0.8))
        ingredientSummaryView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor)
        addButton.anchor(top: nil, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, size: CGSize(width: 0.0, height: 40.0))
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        ingredientSummaryView.backgroundColor = UIColor.lightGray
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let tappedView = touch.view else { return }
        
        if tappedView != containerView && !tappedView.isDescendant(of: containerView) {
            dismiss(animated: true, completion: nil)
        }
    }

}

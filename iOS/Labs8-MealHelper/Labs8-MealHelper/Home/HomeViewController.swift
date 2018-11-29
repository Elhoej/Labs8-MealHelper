//
//  HomieTableViewController.swift
//  Labs8-MealHelper
//
//  Created by Simon Elhoej Steinmejer on 08/11/18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit
import ExpandableButton

class HomeViewController: UIViewController, UICollectionViewDelegate {

    var timer: Timer?
    
    let skyView: SkyView = {
        let view = SkyView()
        view.clipsToBounds = true
        
        return view
    }()
    
    let backgroundImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "mountain"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    let countDownLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = Appearance.appFont(with: 60)
        label.text = "60.00"
        label.sizeToFit()
        
        return label
    }()
    
    
    lazy var collectionView: HomeCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = HomeCollectionView(frame: .zero, collectionViewLayout: layout)
        cv.layer.cornerRadius = 16
        cv.layer.masksToBounds = true
        
        return cv
    }()
    
    let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    lazy var expandableButtonView: ExpandableButtonView = {
        let ebv = ExpandableButtonView(buttonSizes: CGSize(width: 50, height: 50))
        ebv.buttonImages(mainCollapsed: UIImage(named: "plus-icon")!, mainExpanded: UIImage(named: "minus-icon")!, mostLeft: UIImage(named: "alarm_clock")!, left: UIImage(named: "apple")!, right: UIImage(named: "plus-icon")!, mostRight: UIImage(named: "plus-icon")!)
        ebv.buttonColors(main: .white, mostLeft: .white, left: .white, right: .white, mostRight: .white)
        ebv.isLineHidden = true
        ebv.collapseWhenTapped = true
        ebv.delegate = self
        
        return ebv
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        APIClient.shared.fetchMeals { (response) in
            
            DispatchQueue.main.async {
                switch response {
                case .success(let meals):
                    self.collectionView.meals = meals
                case .error:
                    self.showAlert(with: "Unable to load your meals, please check your internet connection and try again.")
                }
            }
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(handleCountdown), userInfo: nil, repeats: true)
    }
    
    @objc private func handleCountdown() {
        var currentTime = Double(countDownLabel.text!)!
        currentTime -= 1
        countDownLabel.text = String(currentTime)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupFooterView()
    }
    
    override func viewDidLayoutSubviews() {
        
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = view.bounds
//        gradientLayer.colors = [UIColor.nightSkyDark.cgColor, UIColor.nightSkyBlue.cgColor]
////        gradientLayer.colors = [UIColor.sunOrange.cgColor, UIColor.morningSkyBlue.cgColor]
//        gradientLayer.locations = [0.0, 0.75]
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//
//        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        
        skyView.setGradientBackground(colorOne: UIColor.nightSkyDark.cgColor, colorTwo: UIColor.nightSkyBlue.cgColor, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0.8, y: 0.3))
    }
    
    private func setupFooterView() {
        
        view.addSubview(skyView)
        skyView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.centerYAnchor, trailing: view.trailingAnchor, size: CGSize(width: 0, height: 0))
        
        view.addSubview(countDownLabel)
        countDownLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 53, left: 0, bottom: 0, right: 0), size: .zero)
        countDownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(backgroundImageView)
        backgroundImageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0))
        
        view.addSubview(collectionView)
        collectionView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12), size: CGSize(width: 0, height: 300))
        
        view.addSubview(footerView)
        footerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0), size: CGSize(width: view.frame.width, height: 50))
        
        view.addSubview(expandableButtonView)
        expandableButtonView.anchor(top: nil, leading: nil, bottom: collectionView.topAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0), size: CGSize(width: 300, height: 50))
        expandableButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

extension HomeViewController: ExpandableButtonViewDelegate {
    
    func didTapButton(at position: ExpandableButtonPosition) {
        switch position {
        case .mostLeft:
            let alarmViewController = AlarmViewController()
            present(alarmViewController, animated: true, completion: nil)
        case .left:
            let mealsTableViewController = MealsTableViewController(navTitle: "Meals")
            let navController = UINavigationController(rootViewController: mealsTableViewController)
            navController.navigationBar.prefersLargeTitles = true
            present(navController, animated: true, completion: nil)
            print("Left")
        case .right:
            print("Right")
        case .mostRight:
            print("Most Right")
        }
    }
}

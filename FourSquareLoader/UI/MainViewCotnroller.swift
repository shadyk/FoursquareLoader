//
//  MainVC.swift
//  test
//
//  Created by Shady Kahaleh on 20/07/2022.
//

import UIKit

class MainViewCotnroller: UIViewController {
    
    private var aboutVC: AboutUsViewController!
    private var locationVC: LocationsViewController!
    
    private lazy var segmentControl: UISegmentedControl = {
        let items = [Localizable.locations, Localizable.about_us]
        let s = UISegmentedControl(items: items)
        s.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        return s
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
        
    convenience init(aboutVC: AboutUsViewController, locationVC: LocationsViewController){
        self.init()
        self.aboutVC = aboutVC
        self.locationVC = locationVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSegmentControl()
        addAboutUs()
        addLocation()
        view.backgroundColor = .white
    }
    
    private func addSegmentControl() {
        view.addSubview(segmentControl)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            segmentControl.heightAnchor.constraint(equalToConstant: 40)
        ])

    }
    
    private func addAboutUs() {
        addChild(aboutVC)
        view.addSubview(aboutVC.view)
        aboutVC.didMove(toParent: self)
        aboutVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            aboutVC.view.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 12),
            aboutVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            aboutVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            aboutVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        aboutVC.view.isHidden = true
    }
    
    private func addLocation() {
        addChild(locationVC)
        view.addSubview(locationVC.view)
        locationVC.view.translatesAutoresizingMaskIntoConstraints = false
        locationVC.didMove(toParent: self)
        NSLayoutConstraint.activate([
            locationVC.view.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 12),
            locationVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            locationVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            locationVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        locationVC.view.isHidden = false
    }
    
    @objc private func segmentAction(_ segmentedControl: UISegmentedControl) {
        aboutVC.view.isHidden = true
        locationVC.view.isHidden = true
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            locationVC.view.isHidden = false
            break
        case 1:
            aboutVC.view.isHidden = false
            break
        default:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

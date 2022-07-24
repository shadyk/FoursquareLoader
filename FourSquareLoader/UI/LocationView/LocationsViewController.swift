//
//  AbousUsViewController.swift
//  test
//
//  Created by Shady Kahaleh on 20/07/2022.
//

import UIKit
import CoreLocation

class LocationsViewController: UIViewController {
    
    private var controller: LocationsListController?
    private var tableModel = [TableCellController]() {
        didSet {
            DispatchQueue.main.async {
                
                self.showEmptyLabel(self.tableModel.isEmpty)
                self.tableView.reloadData()
            }
        }
    }
    
    private func showEmptyLabel(_ value: Bool){
        if value{
            tableView.addSubview(lblEmpty)
            NSLayoutConstraint.activate([
                self.lblEmpty.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
                self.lblEmpty.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
            ])
        }
        else{
            lblEmpty.removeFromSuperview()
        }
    }
    
    private lazy var tableView: UITableView = {
        let t = UITableView(frame: .zero, style: .grouped)
        t.backgroundColor = .white
        t.translatesAutoresizingMaskIntoConstraints = false
        t.rowHeight = UITableView.automaticDimension
        t.estimatedRowHeight = 1
        t.separatorStyle = .none
        t.showsVerticalScrollIndicator = false
        t.delegate = self
        t.dataSource = self
        return t
    }()
    
    
    private lazy var lblEmpty: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20)
        l.textColor = .black
        l.textAlignment = .left
        l.numberOfLines = 0
        l.text = Localizable.emptyText
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(contoller: LocationsListController){
        self.init()
        self.controller = contoller
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        LocationManager.shared.requestAlwaysAuthorization(){ [weak self] in
            guard let self = self else {return}
            self.loadLocations()
        }
    }
    
    private func loadLocations() {
        controller?.loadLocations( success: { [weak self] model in
            self?.tableModel = model
        }, fail: { [weak self] in
            self?.showAlert(message: $0)
        })
    }
    
    private func setupInterface() {
        view.addSubview(tableView)
        tableView.register(LocationTableCell.self, forCellReuseIdentifier: "LocationTableCell")
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant:  12)
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension LocationsViewController: UITableViewDelegate , UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        controller?.didSelect(nav: self.navigationController!, location: cellController(forRowAt: indexPath).viewModel!)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellController = cellController(forRowAt: indexPath)
        return cellController.view(in: tableView)
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> TableCellController {
        return tableModel[indexPath.row]
    }
}

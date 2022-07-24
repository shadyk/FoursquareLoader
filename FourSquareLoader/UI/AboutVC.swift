//
//  AbousUsViewController.swift
//  test
//
//  Created by Shady Kahaleh on 20/07/2022.
//

import UIKit

class AboutUsViewController: UIViewController {

    private var loader: AboutUsLoader?
    
    private var lblAboutUs: UITextView = {
        let l = UITextView()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .systemFont(ofSize: 14)
        l.backgroundColor = .clear
        l.textColor = .black
        l.textAlignment = .left
        l.showsVerticalScrollIndicator = false
        l.showsHorizontalScrollIndicator = false
        l.isEditable = false
        return l
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
        
    convenience init(loader: AboutUsLoader){
        self.init()
        self.loader = loader
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupInterface()
    }
    private func setupInterface(){
        view.addSubview(lblAboutUs)
        lblAboutUs.text = loader?.getText()
        NSLayoutConstraint.activate([
            lblAboutUs.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            lblAboutUs.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            lblAboutUs.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            lblAboutUs.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 24)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

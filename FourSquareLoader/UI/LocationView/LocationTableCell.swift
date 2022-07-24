//
//  Created by Shady
//  All rights reserved.
//  

import UIKit

class LocationTableCell: UITableViewCell {
    
    var lblName: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20)
        l.textColor = .black
        l.textAlignment = .left
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var sep = LineSeparator()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInterface()
    }
    
    private func setupInterface(){
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(lblName)
        contentView.addSubview(sep)
        sep.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lblName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lblName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            lblName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            lblName.bottomAnchor.constraint(equalTo: sep.topAnchor, constant: -24)
        ])
        
        NSLayoutConstraint.activate([
            sep.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            sep.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            sep.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            sep.heightAnchor.constraint(equalToConstant: 1),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

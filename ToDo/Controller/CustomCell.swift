//
//  CustomCell.swift
//  ToDo
//
//  Created by Saruar on 17.05.2023.
//

import Foundation
import UIKit


class CustomCell: UITableViewCell{
    
    
    static let identifier = "CustomTableViewCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        
        backgroundColor = UIColor.white
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
        clipsToBounds = true
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

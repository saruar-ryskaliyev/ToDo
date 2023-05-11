//
//  CustomCell.swift
//  ToDo
//
//  Created by Saruar on 11.05.2023.
//

import UIKit

class CustomCell: UITableViewCell{
    static let identifier = "CustomCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.layer.cornerRadius = 15
        self.contentView.clipsToBounds = true
        self.contentView.layer.borderWidth = 1
        
        self.contentView.backgroundColor = .systemGray
    }
    
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            let newWidth = frame.width * 0.95 // get 80% width here
            let space = (frame.width - newWidth) / 2
            frame.size.width = newWidth
            frame.origin.x += space

            super.frame = frame

        }
    }
    


    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

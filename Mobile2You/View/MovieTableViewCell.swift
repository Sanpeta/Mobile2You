//
//  MovieTableViewCell.swift
//  Mobile2You
//
//  Created by Sidnei de Souza Junior on 23/09/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var imageCell: UIImageView!
    var titleCell: UILabel!
    var yearCell: UILabel!
    var genreCell: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(named: Constants.backgroundColor)
        self.frame.size.width = widthScreen
        self.frame.size.height = heightScreen * 0.11
        
        imageCell = UIImageView(
            frame: CGRect(
                x: 8,
                y: 8,
                width: self.frame.width * 0.15,
                height: self.frame.height - 16
            )
        )
        imageCell.contentMode = .scaleAspectFill
        
        
        titleCell = UILabel(
            frame: CGRect(
                x: imageCell.frame.maxX + 8,
                y: self.frame.size.height * 0.30,
                width: self.frame.size.width * 0.70,
                height: self.frame.size.height * 0.20
            )
        )
        titleCell.textColor = .white
        titleCell.textAlignment = .left
        titleCell.font = UIFont.boldSystemFont(ofSize: 18)
        
        
        yearCell = UILabel(
            frame: CGRect(
                x: imageCell.frame.maxX + 8,
                y: titleCell.frame.maxY + 8,
                width: self.frame.size.width * 0.10,
                height: self.frame.size.height * 0.20
            )
        )
        yearCell.textColor = .white
        yearCell.textAlignment = .left
        yearCell.font = yearCell.font.withSize(14)
        
        
        genreCell = UILabel(
            frame: CGRect(
                x: yearCell.frame.maxX,
                y: titleCell.frame.maxY + 8,
                width: self.frame.size.width * 0.60,
                height: self.frame.size.height * 0.20
            )
        )
        genreCell.textColor = .white
        genreCell.textAlignment = .left
        genreCell.font = genreCell.font.withSize(14)
        
        self.contentView.addSubview(imageCell)
        self.contentView.addSubview(titleCell)
        self.contentView.addSubview(yearCell)
        self.contentView.addSubview(genreCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

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
        imageCell = UIImageView(
            frame: CGRect(
                x: 8,
                y: 16,
                width: self.frame.size.width/10,
                height: self.frame.size.height - 16
            )
        )
        imageCell.contentMode = .scaleToFill
        
        titleCell = UILabel(
            frame: CGRect(
                x: imageCell.frame.maxX + 8,
                y: 16,
                width: self.frame.size.width/10,
                height: self.frame.size.height - 16
            )
        )
        
        yearCell = UILabel(
            frame: CGRect(
                x: imageCell.frame.maxX + 8,
                y: 16,
                width: self.frame.size.width/10,
                height: self.frame.size.height - 16
            )
        )
        
        genreCell = UILabel(
            frame: CGRect(
                x: yearCell.frame.maxX + 8,
                y: 16,
                width: self.frame.size.width/10,
                height: self.frame.size.height - 16
            )
        )
        
        self.contentView.addSubview(imageCell)
        self.contentView.addSubview(titleCell)
        self.contentView.addSubview(yearCell)
        self.contentView.addSubview(genreCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

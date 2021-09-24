//
//  MovieTableViewCell.swift
//  Mobile2You
//
//  Created by Sidnei de Souza Junior on 23/09/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let identifier = "movieCell"
    
    //MARK: - Setting Image Cell
    let imageCell: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: - Setting Title Cell
    let titleCell: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    //MARK: - Setting Year Cell
    var yearCell: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    //MARK: - Setting Genre Cell
    var genreCell: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //MARK: - Setting Background Color
        self.backgroundColor = UIColor(named: Constants.backgroundColor)
        
        //MARK: - Adding the Subviews
        self.contentView.addSubview(imageCell)
        self.contentView.addSubview(titleCell)
        self.contentView.addSubview(yearCell)
        self.contentView.addSubview(genreCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //MARK: - Setting Size of the Cell
        self.frame.size.width = widthScreen
        self.frame.size.height = heightScreen * 0.11
        
        //MARK: - Setting Position and Size of the Image Cell
        imageCell.frame = CGRect(
            x: 8,
            y: 8,
            width: self.frame.width * 0.15,
            height: self.frame.height - 16
        )
        
        
        //MARK: - Setting Position and Size of the Title Cell
        titleCell.frame = CGRect(
            x: imageCell.frame.maxX + 8,
            y: self.frame.size.height * 0.30,
            width: self.frame.size.width * 0.70,
            height: self.frame.size.height * 0.20
        )
        
        //MARK: - Setting Position and Size of the Year Cell
        yearCell.frame = CGRect(
            x: imageCell.frame.maxX + 8,
            y: titleCell.frame.maxY + 8,
            width: self.frame.size.width * 0.10,
            height: self.frame.size.height * 0.20
        )
        
        //MARK: - Setting Position and Size of the Genre Cell
        genreCell.frame = CGRect(
            x: yearCell.frame.maxX,
            y: titleCell.frame.maxY + 8,
            width: self.frame.size.width * 0.60,
            height: self.frame.size.height * 0.20
        )
        
    }
}

//
//  heroImage.swift
//  Mobile2You
//
//  Created by Sidnei de Souza Junior on 22/09/21.
//

import UIKit

class HeroImage: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

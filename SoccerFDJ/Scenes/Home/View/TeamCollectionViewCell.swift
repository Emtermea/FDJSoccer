//
//  TeamCollectionViewCell.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 05/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import UIKit
import Kingfisher

class TeamCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Properties
    
    var viewModel: HomeTeamsListViewModelProtocol? {
        didSet {
            if let imageUrl = self.viewModel?.imageUrl, let url = URL(string: imageUrl) {
                self.imageView.kf.setImage(with: url,
                                           placeholder: UIImage(named: "team-placeholder"),
                                           options: [.transition(.fade(1))])
            }
        }
    }
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

//
//  TeamCollectionViewCell.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 05/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Properties
    var viewModel: HomeTeamsListViewModelProtocol? {
        didSet {
            //TO DO - KINGFISHER
            self.imageView.image = UIImage(named: "team_placeholder")
            
            if let imageUrl = self.viewModel?.imageUrl, let url = URL(string: imageUrl) {
                
            }
        }
    }
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

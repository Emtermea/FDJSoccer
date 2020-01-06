//
//  AutoCompletionTableViewCell.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 05/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import UIKit

class AutoCompletionTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlet
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    //MARK: - Properties
    
    var viewModel: HomeLeaguesListViewModelProtocol? {
        didSet {
            self.titleLabel.text = self.viewModel?.title
        }
    }
    
    //MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

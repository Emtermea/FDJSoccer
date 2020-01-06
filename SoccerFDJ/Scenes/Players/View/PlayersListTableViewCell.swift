//
//  PlayersListTableViewCell.swift
//  SoccerFDJ
//
//  Created by Emmanuelle Termeau on 05/01/2020.
//  Copyright © 2020 Emmanuelle Termeau. All rights reserved.
//

import UIKit

class PlayersListTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: Properties
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Init
    
    func setup(with player: PlayersListViewModelProtocol?) {
        self.playerNameLabel.text = player?.name ?? ""
        self.positionLabel.text = player?.position ?? ""
        
        self.birthDateLabel.text = "birthate: \(player?.birthDate ?? "")"
        self.priceLabel.text = "price: \(player?.price ?? "")"
        
        var pictureUrl: URL? = nil
        if let profileUrl = player?.profileUrl, let url = URL(string: profileUrl) {
            pictureUrl = url
        } else if let thumbUrl = player?.thumbUrl, let url = URL(string: thumbUrl) {
            pictureUrl = url
        }
        self.profileImageView.kf.indicatorType = .activity
        self.profileImageView.kf.setImage(with: pictureUrl,
                                          placeholder: UIImage(named: "player-placeholder"),
                                          options: [.transition(.fade(1))])
    }
    
}

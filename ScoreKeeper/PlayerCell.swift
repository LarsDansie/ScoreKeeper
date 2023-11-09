//
//  PlayerCell.swift
//  ScoreKeeper
//
//  Created by Lars Dansie on 11/8/23.
//

import UIKit

protocol addedPLayer {
    func needsAPlayer(player: Player?)
}

class PlayerCell: UITableViewCell {
    
    @IBOutlet weak var playerScoreLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreStepper: UIStepper!
    
    var delegate: addedPLayer?
    var player: Player?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        playerScoreStepper.maximumValue = .infinity
        playerScoreStepper.minimumValue = 0
    }
    
    @IBAction func playerScoreStepperTapped(_ sender: UIStepper) {
        let newScoreInt = Int(sender.value)
        playerScoreLabel.text = String(newScoreInt)
        player?.currentScore = newScoreInt
        delegate?.needsAPlayer(player: player)
    }
    
    func updatePlayerCell(with player: Player) {
        self.player = player
        playerScoreLabel.text = String(player.currentScore)
        playerNameLabel.text = player.name
        playerScoreStepper.value = Double(player.currentScore)
    }
    
    
}

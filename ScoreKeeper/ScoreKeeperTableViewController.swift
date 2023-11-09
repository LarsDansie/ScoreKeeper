//
//  ScoreKeeperTableViewController.swift
//  ScoreKeeper
//
//  Created by Lars Dansie on 11/3/23.
//

import UIKit

class ScoreKeeperTableViewController: UITableViewController {
    
    var players = [Player]()
    
    var sortedPlayers: [Player] {
        players.sorted(by: >)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedPlayers = Player.loadPlayers() {
            players = savedPlayers
        } else {
            players = Player.loadSamplePlayers()
        }
        
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
           "PlayerCellIdentifier", for: indexPath) as! PlayerCell
        
        cell.delegate = self
        
        let player = sortedPlayers[indexPath.row]
        
        cell.updatePlayerCell(with: player)
        

        return cell
    }
    
    
    @IBAction func unwindToScoreBoard(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as!
           NewPlayerTableViewController
    
        if let player = sourceViewController.player {
            if let indexOfExistingPlayer = players.firstIndex(of: player) {
                players[indexOfExistingPlayer] = player
                tableView.reloadRows(at: [IndexPath(row: indexOfExistingPlayer,
                   section: 0)], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: players.count, section: 0)
                players.append(player)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        Player.savePlayers(players)
    }

    // MARK: - Navigation


}

extension ScoreKeeperTableViewController: addedPLayer {
    func needsAPlayer(player: Player?) {
        guard let player else { return}
        if let row = players.firstIndex(of: player) {
            players[row] = player
        }
        tableView.reloadData()
    }
}

//
//  NewPlayerTableViewController.swift
//  ScoreKeeper
//
//  Created by Lars Dansie on 11/7/23.
//

import UIKit


class NewPlayerTableViewController: UITableViewController {
    
    
    @IBOutlet weak var playerNameTextField: UITextField!
    @IBOutlet weak var currentScoreTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var player: Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func savePlayerButtonTapped(_ sender: Any) {
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let name = playerNameTextField.text!
        guard let scoreString = currentScoreTextField.text,
              let scoreInt = Int(scoreString) else {
            print("Everything broke")
            return
        }
        
        if player != nil {
            player?.name = name
            player?.currentScore = scoreInt
        } else {
            player = Player(name: name, currentScore: scoreInt)
        }
    }

}

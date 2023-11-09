//
//  Player.swift
//  ScoreKeeper
//
//  Created by Lars Dansie on 11/7/23.
//

import Foundation


struct Player: Equatable, Codable, Comparable {
    
    let id: UUID
    var name: String
    var currentScore: Int
    
    init( name: String, currentScore: Int) {
        self.id = UUID()
        self.name = name
        self.currentScore = currentScore
    }
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func loadPlayers() -> [Player]? {
        guard let codedPlayers = try? Data(contentsOf: archiveURL) else
            {return nil}
        let propertyListDecoder = PropertyListDecoder()
        
        return try? propertyListDecoder.decode(Array<Player>.self, from: codedPlayers)
    }
    
    static func loadSamplePlayers() -> [Player] {
        let player1 = Player(name: "Mr. Obama", currentScore: 10)
        
        let player3 = Player(name: "Mr. Can't Click", currentScore: 0)
    
        return [player1, player3]
    }
    
    static func < (lhs: Player, rhs: Player) -> Bool {
        return lhs.currentScore < rhs.currentScore
    }
    
    static let documentsDirectory =
       FileManager.default.urls(for: .documentDirectory,
       in: .userDomainMask).first!
    static let archiveURL =
       documentsDirectory.appendingPathComponent("players")
       .appendingPathExtension("plist")
    
    static func savePlayers(_ players: [Player]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedPlayers = try? propertyListEncoder.encode(players)
        try? codedPlayers?.write(to: archiveURL, options: .noFileProtection)
    }
}

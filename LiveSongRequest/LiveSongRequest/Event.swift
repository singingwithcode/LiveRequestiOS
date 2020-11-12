//
//  Event.swift
//  LiveSongRequest
//
//

import Foundation

//var eventList : Event = Event()

//tempdata
var eventList = [Event(eventName: "Sample Event", adminCode: "admin", eventCode: "admin", songs: [Song("FRIENDS", "Marshmellow"), Song("These Days", "Rudimental"), Song("God's Plan", "Drake"), Song("Breathe", "Jax Jones"), Song("TNT", "ACDC"), Song("Yeah", "Usher"), Song("Low", "Flo Rida"), Song("How You Love Me", "3lau"), Song("Beggers", "Krewella"), Song("CrushCrushCrush", "Paramore"), Song("Miss Jackson", "Panic!"), Song("Country Girl", "Luke Bryan")])]

enum `Vote`: String {
    case UP = "UP"
    case DOWN = "DOWN"
    case NONE = "NONE"
}

class Event {
    let eventName: String
    var songs: [Song]
    let adminCode: String
    let eventCode: String
    
    init(eventName: String, adminCode: String, eventCode: String, songs: [Song]) {
        self.adminCode = adminCode
        self.eventCode = eventCode
        self.songs = songs
        self.eventName = eventName
    }
}

class Song {
    let songName: String
    let artistName: String
    var votes: Votes
    
    init(_ songName: String, _ artistName: String) {
        self.songName = songName
        self.artistName = artistName
        self.votes = Votes()
    }
}

class Votes {
    //userID to their Vote as a dictionary
    private var userIDToVotes = [Int: Vote]()
    
    init(){}
    
    func countVotes() -> Int {
        var count : Int = 0
        for v in userIDToVotes {
            if v.value == Vote.UP {
                count = count + 1
            } else if v.value == Vote.DOWN {
                count = count - 1
            }
            //we are ignoring NONE
        }
        return count
    }
    
    func addVote(userID: Int, vote: Vote) {
        
        var userPermission: Bool = true //default to yes unless they exist as UP or DOWN
        
        if let existingVote = userIDToVotes[userID] {
            if existingVote == Vote.NONE {
                //user may vote
                userIDToVotes.updateValue(vote, forKey: userID)
            } else if existingVote == Vote.UP || existingVote == Vote.DOWN {
                //user may not vote, forbid
                userPermission = false
                //change to None
                userIDToVotes.updateValue(Vote.NONE, forKey: userID)
            }
        }
        
        if userPermission == true {
            //user may vote if not forbidden
            userIDToVotes.updateValue(vote, forKey: userID)
        }
    }
    
    //returns NONE even if not found in []
    func getUserVote(userID: Int) -> Vote {
        if let vote = userIDToVotes[userID] {
            return vote
        } else {
            return Vote.NONE
        }
    }
}



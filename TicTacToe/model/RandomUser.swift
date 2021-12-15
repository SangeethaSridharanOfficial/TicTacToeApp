//
//  RandomUser.swift
//  TicTacToe
//
//  Created by user202299 on 12/12/21.
//

import Foundation

struct RandomUser: Codable{
    var results: [RandomUsers]
}

struct RandomUsers: Codable{
    var gender: String;
    var name: Name;
    var picture: Picture
}

struct Name: Codable{
    var first: String;
    var last: String;
}

struct Picture: Codable{
    var large: String
}


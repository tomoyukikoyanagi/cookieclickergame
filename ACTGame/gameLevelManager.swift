//
//  gameLevelManager.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/07/05.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation


func getGameLevel(dreamArray : [Int]) -> Int{
    var gameLevel = 0
    if dreamArray[0] == 1 {
        gameLevel += 1
    }
    if dreamArray[6] == 1 {
        gameLevel += 1
    }
    return gameLevel
}

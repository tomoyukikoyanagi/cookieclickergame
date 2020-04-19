//
//  GameConstants.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/04/19.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation

enum sheepName : String{
    case coridale =  "coridale"
    case suffolk = "suffolk"
    case melino = "melino"
    case sheep4 = "***"
    case sheep5 = "****"
    case sheep6 = "*****"
    case sheep7 = "******"
}

let sheepNameArray : [sheepName] = [sheepName.coridale, sheepName.suffolk, sheepName.melino, sheepName.sheep4, sheepName.sheep5, sheepName.sheep6, sheepName.sheep7]

let sheepCardName : [String] = ["card1.png","card2.png","card0.png","card0.png","card0.png","card0.png","card0.png","card0.png"]


struct coridale {
    static let addSPS = [1,2,3,4,5,6,7,8,9,10]
    static let price = [20,200,2000,20000,200000,2000000,7,8,9,10]
}

func getSPSStruct(sheep: sheepName) ->[Int]{
    if sheep == sheepName.coridale {
        return coridale.addSPS
    } else {
        return [1,2,3,4,5,6,7,8,9,10]
    }
}

func getPriceStruct(sheep: sheepName) -> [Int]{
    if sheep == sheepName.coridale {
        return coridale.price
    } else {
        return [0,0,0,0,0,0,0,0,0,0]
    }
}


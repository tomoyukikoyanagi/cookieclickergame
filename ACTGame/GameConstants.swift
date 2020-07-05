//
//  GameConstants.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/04/19.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation

enum sheepName : String{
    case corriedale =  "corriedale"
    case suffolk = "suffolk"
    case merino = "merino"
    case lincoln = "lincoln"
    case valleyblacknose = "valleyblacknose"
    case karacul = "karacul"
    case jacob = "jacob"
}

enum areaName : String {
    case farm = "farm"
    case mountain = "mountain"
    case city = "city"
    case moon = "moon"
    case galaxy = "galaxy"
}

enum itemName : String {
    case drink = "drink"
    case dog = "dog"
    case wolf = "wolf"
}

let THRESHOLD1 : Int = 100
let THRESHOLD2 : Int = 10000
let THRESHOLD3 : Int = 1000000
let THRESHOLD4 : Int = 100000000
let THRESHOLD5 : Int = 10000000000
let THRESHOLD6 : Int = 1000000000000

let buttonNameArrayJP : [String] = ["ドリンク","","強化","ゆめ日記","設定"]
let sheepNameArray : [sheepName] = [sheepName.corriedale, sheepName.suffolk, sheepName.merino, sheepName.lincoln, sheepName.valleyblacknose, sheepName.karacul, sheepName.jacob]
let sheepNameArrayJp : [String] = ["コリデール","サフォーク","メリノ","リンカーン","ヴァレーブラックノーズ","カラクール ","ヤコブ"]
let areaNameArray : [areaName] = [areaName.farm, areaName.mountain, areaName.city, areaName.moon, areaName.galaxy]
let areaNameArrayJp : [String] = ["農場","山","都市","月","宇宙"]
let itemNameArray : [itemName] = [itemName.drink, itemName.dog, itemName.wolf]
let itemNameArrayJp : [String] = ["栄養ドリンク","牧羊犬", "オオカミを呼ぶ笛"]
let sheepCardName : [String] = ["corriedale.png","suffolk.png","merino.png","lincoln.png","valleyblacknose.png","karacul.png","jacob.png"]
let areaCardName : [String] = ["farm.png", "mountain.png","city.png","moon.png","universe.png",]
let itemCardName : [String] = ["drink.png","dog.png","flute.png",]
let sheepImageName : [String] = ["test.png","test.png","test.png","test.png","test.png","test.png","test.png"]
let bgImageName : [String] = ["area1.png","area2.png","area2.png","area3.png","area4.png",]

let drinkModeMultiplier = 10
let drinkModeTime = 10.0


struct LevelStruct {
    var amount : [Int]? = nil
    var price : [Int]
    var type : gameSceneManager.purchaseType
    var imageName : String? = nil
    
    init (price: [Int]){
        self.price = price
        self.type = .item
    }
    
    init (amount: [Int], price: [Int], type: gameSceneManager.purchaseType, image: String){
        self.amount = amount
        self.price = price
        self.type = type
        self.imageName = image
    }
}

let corriedale : LevelStruct = LevelStruct(amount: [0,1,2,3,4,5,6,7,8,9,10], price:[0,10,20,30,40,50,60,70,80,90,100], type: .sheep, image: sheepImageName[0])

let suffolk : LevelStruct = LevelStruct(amount: [0,10,20,30,40,50,60,70,80,90,100], price:[0,200,200,2000,20000,200000,2000000,7,8,9,10], type: .sheep, image: sheepImageName[1])

let merino : LevelStruct = LevelStruct(amount:  [0,100,200,300,400,500,600,700,800,900,1000], price:[0,20000,200,2000,20000,200000,2000000,7,8,9,10], type: .sheep, image: sheepImageName[2] )

let lincoln : LevelStruct = LevelStruct(amount: [0,1000,2000,3000,4000,5000,6000,7000,8000,9000,10000], price:[0,20,200,2000,20000,200000,2000000,7,8,9,10], type: .sheep, image: sheepImageName[3])

let valleyblacknose: LevelStruct = LevelStruct(amount: [0,10000,20000,30000,40000,50000,60000,70000,80000,90000,100000], price:[0,20,200,2000,20000,200000,2000000,7,8,9,10], type: .sheep, image: sheepImageName[4])

let karacul : LevelStruct = LevelStruct(amount:[0,100000,200000,300000,400000,500000,600000,700000,800000,900000,1000000], price:[0,2000,200,2000,20000,200000,2000000,7,8,9,10], type: .sheep, image: sheepImageName[5])

let jacob : LevelStruct = LevelStruct(amount: [0,1000000,2000000,3000000,4000000,5000000,6000000,7000000,8000000,9000000,10000000], price: [0,10000000000,10000000000,10000000000,10000000000,10000000000,10000000000,10000000000,10000000000,10000000000,10000000000], type: .sheep, image: sheepImageName[6])

let farm : LevelStruct = LevelStruct(amount: [0,1,2,3,4,5,2,2,2,2,2,2], price: [0,0,1000,2000,20000,200000,2000000,2000000,2000000,2000000,20000000], type: .area, image: bgImageName[0])

let mountain : LevelStruct = LevelStruct(amount: [0,2,4,6,8,10,7,8,9,10], price: [0,10,200,2000,20000,200000,2000000,2000000,2000000,2000000,20000000], type: .area, image: bgImageName[1])

let city : LevelStruct = LevelStruct(amount: [0,4,8,16,32,6,7,8,9,10], price: [0,10,200,2000,20000,200000,2000000,2000000,2000000,2000000,20000000], type: .area, image: bgImageName[2])

let moon : LevelStruct = LevelStruct(amount: [0,8,16,32,64,6,7,8,9,10], price: [10,200,2000,20000,200000,2000000,2000000,2000000,2000000,20000000], type: .area, image: bgImageName[3])

let galaxy : LevelStruct = LevelStruct(amount: [0,2,3,4,5,6,7,8,9,10], price: [0,10,200,2000,20000,200000,2000000,2000000,2000000,2000000,20000000], type: .area, image: bgImageName[4])

let drink : LevelStruct = LevelStruct(price: [10])

let dog : LevelStruct = LevelStruct(price: [10])

let wolf : LevelStruct = LevelStruct(price: [10])

func getLevelStruct(type: gameSceneManager.purchaseType, no: Int) -> LevelStruct{
    if type == gameSceneManager.purchaseType.sheep{
        switch no {
        case 0:
            return corriedale
        case 1:
             return suffolk
        case 2:
            return merino
        case 3:
            return lincoln
        case 4:
            return valleyblacknose
        case 5:
            return karacul
        case 6:
            return jacob
        default:
            return LevelStruct(amount: [0,0,0,0,0,0,0], price: [0,0,0,0,0,0,0], type: .sheep, image: sheepImageName[0])
        }
    }else if type == gameSceneManager.purchaseType.area{
        switch no {
        case 0:
            return farm
        case 1:
             return mountain
        case 2:
            return city
        case 3:
            return moon
        case 4:
            return galaxy
        default:
            return LevelStruct(amount: [0,0,0,0,0], price: [0,0,0,0,0], type: .area, image: bgImageName[0])
        }
    } else {
        switch no {
        case 0:
            return drink
        case 1:
            return dog
        case 2:
            return wolf
        default:
            return LevelStruct(price: [0])
        }
    }
}

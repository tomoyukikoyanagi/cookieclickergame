//
//  sheepManager.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/07/05.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation

let SHEEPCARDNUM:Int = 10

class sheepManager {
    static var shared = sheepManager()
    
    var sheeps : Int = 20000000
    var sheepsPerTap : Int = 0
    var sheepsPerSecond : Int = 0
    var drinkUsed : Int = 0
//        解放状態
    var sheepLevelArray : [Int] = [1,0,0,0,0,0,0]
    var areaLevelArray : [Int] = [0,0,0,0,0]
    
    var drinkMode = false
    var countMode : countMode = .normal
    
//    リセットしない変数
    private var drinkPossessed : Int = 1
    private var dreamFragment : Int = 10
    private var storyLevel : Int = 0
    private var currentAreaNo : Int = 0

//    ひとまずご50要素
    var dreamArray : [Int] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,]
    
    private init(){}
    
    func resetSharedInstance() {
        sheeps = 0
        sheepsPerSecond = 0
        sheepsPerTap = 0
        drinkUsed = 0
        sheepLevelArray = [1,0,0,0,0,0,0]
        areaLevelArray = [0,0,0,0,0]
        drinkMode = false
        countMode = .normal
        
    }
    
    func addSPT() {
        sheeps += sheepsPerTap
    }
    
    func decreaseSheep(amount : Int) {
        sheeps -= amount
    }
    
    func addSPS() {
        sheeps += sheepsPerSecond
    }

    func increaseSPT(amount: Int){
        sheepsPerTap += amount
    }
    
    func updateSPT() {
        sheepsPerTap = 0
        for i in 0 ... 6{
            guard let levelStruct = getLevelStruct(type: .sheep, no:i).amount else {return}
            sheepsPerTap += levelStruct[sheepLevelArray[i]]
        }
        if drinkMode == true {
            sheepsPerTap *= 2
        }
    }
    
    func increaseSPS(amount: Int){
        sheepsPerSecond += amount
    }
    
    func changeCurrentArea(areaNo : Int){
        if  areaNo < areaLevelArray.count {
            currentAreaNo = areaNo
        }
    }
    
    func updateSPS() {
        let spsArray = getLevelStruct(type: .area, no: currentAreaNo).amount
        let level = areaLevelArray[currentAreaNo]
        sheepsPerSecond = spsArray?[level] ?? 0
    }
    
    func updateSPS(sps : Int){
        sheepsPerSecond = sps
    }
    
    func updateLevel(type : purchaseType, array: [Int]){
        if type == .sheep{
            sheepLevelArray = array
        } else if type == .area{
            areaLevelArray = array
        }
    }
    
    func levelUp(type : purchaseType, id: Int){
        if type == .sheep{
            if sheepLevelArray[id] < 10{
                sheepLevelArray[id] += 1
            }
        } else if type == .area {
            if areaLevelArray[id] < 10 {
                areaLevelArray[id] += 1
            }
        }
        updateSPT()
        updateSPS()
    }
    
    func isLevelMax(type : purchaseType, id: Int) -> Bool{
        var level = 0
        if type == .sheep {
            level = sheepLevelArray[id]
        } else if type == .area {
            level = areaLevelArray[id]
        }
        if level >= 10 {
            return true
        } else {
            return false
        }
    }
    
    func addDrink(){
        drinkPossessed += 1
    }
    
    func useDrink(){
        drinkPossessed -= 1
        drinkUsed += 1
    }
    
    func updateDreamFragment(){
        addDreamFragment(df: exchangeSheepToFragment(sheeps: sheeps))
    }
    
    func exchangeSheepToFragment(sheeps: Int) -> Int{
        var drops : Int = sheeps / 100
        return drops
    }
    
    func addDreamFragment(df: Int){
        dreamFragment += df
    }
    
    func getDreamFragment() -> Int{
        return dreamFragment
    }
    
    func substractDreamFragment(int : Int){
         self.dreamFragment -= int
    }
    
    func checkStoryLevel(){
        storyLevel = getGameLevel(dreamArray: dreamArray)
    }
    
    func getID() -> Int{
        let id = getTalkListID(sheep: self)
        print("id: \(id)")
        return id
    }
    
    func updateDreamArray(TLSturct: talkListStruct) {
        dreamArray[TLSturct.getID()] = 1
        checkStoryLevel()
    }
    
    func endDrinkMode() {
        drinkMode = false
    }
    
    func startDrinkMode(){
        drinkMode = true
    }
    
    func getStoryLevel() -> Int{
        return storyLevel
    }
    
    func getCurrentAreaNumber() -> Int{
        return currentAreaNo
    }
    
    func getDrinkPossessed() -> Int {
        return drinkPossessed
    }
    
    func getLevel(type: purchaseType, id: Int) -> Int{
        if type == .sheep{
            return sheepLevelArray[id]
        } else if type == .area{
            return areaLevelArray[id]
        } else {
            return 0
        }
    }
    
    func isPurchasable(price: Int) -> Bool{
        if price <= sheeps{
            return true
        } else {
            return false
        }
    }

    
    
}

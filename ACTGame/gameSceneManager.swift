//
//  gameSceneManager.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/04/10.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

let SHEEPCARDNUM:Int = 10


   
    

class sheepManager {
    
    var sheeps : Int = 0
    var sheepsPerTap : Int = 0
    var sheepsPerSecond : Int = 0
    var drinkUsed : Int = 0
//        羊の種類に応じた選択肢
    var sheepLevelArray : [Int] = [1,0,0,0,0,0,0]
    var areaLevelArray : [Int] = [0,0,0,0,0]
    static var shared = sheepManager()
    
    var drinkMode = false
    
//    不動変数
    var drinkPossessed : Int = 1
    var dreamFragment : Int = 10
    var storyLevel : Int = 0
    
    var currentAreaNo : Int = 0
    
    
    
    
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
    
    func updateLevel(type : gameSceneManager.purchaseType, array: [Int]){
        if type == .sheep{
            sheepLevelArray = array
        }
        if type == .area{
            areaLevelArray = array
        } else {
            
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
    
    func storyLevelUp(){
        storyLevel += 1
    }
    
    func getTalkList() -> talkListStruct{
        var filteredArray : [talkListStruct]
        filteredArray = talkListArray.filter{ $0.getBool(storyLevel: self.storyLevel, sheep: self.sheeps, drinkUsed: self.drinkUsed, sheepLevel: self.sheepLevelArray, areaLevel: self.areaLevelArray) }
        return filteredArray[filteredArray.count - 1]
    }
    
    func endDrinkMode() {
        drinkMode = false
    }
    
    func startDrinkMode(){
        drinkMode = true
    }
}

class gameSceneManager {
    
    static let shared = gameSceneManager()
    
    private init() {

       }
    
    public func launch() {
           firstLaunch()
       }
    
    enum purchaseType : String {
        case sheep = "sheep"
        case area = "area"
        case item = "item"
    }
    
    enum SceneType: Int {
        case TopMenu, Dairy, Settings, DreamScene
    }
    
    enum ImageName : String {
        case sheepbutton = "sheepbutton.png"
        case sleepButton = "sleepbutton.png"
        
        case card0 = "card0.png"
        case card1 = "card1.png"
        case card2 = "card2.png"
        
        case popmenuBackground1 = "popmenu1.png"
        case popmenuBackground2 = "popmenu2.png"
        case popmenuBackground3 = "popmenu3.png"
        case dreamFragmentLogo = "dreamDrop.png"
        case spsLogo = "spsLogo.png"
        case sptLogo = "sptLogo.png"
    
        case popmenuCancelButton = "popmenu_cancel.png"
        
        case drink_enabled = "drinkbutton_enabled.png"
        case drink_disabled = "drinkbutton_disabled.png"
    }
    
    var sheepCardName : [String]{
        get{
            return ["sheep1.png","sheep2.png","sheep0.png","sheep0.png","sheep0.png","sheep0.png"]
        }
        
    }
    
    private func firstLaunch(){

        if !UserDefaults.standard.bool(forKey: "ifFirstLaunch") {
            print("this is our first launch")
            ACTPlayerStats.shared.setSounds(true)
            ACTPlayerStats.shared.saveMusicVolume(0.7)
            UserDefaults.standard.set(true, forKey: "ifFirstLaunch")
            UserDefaults.standard.synchronize()
        }
    }

    func transition(_ fromScene: SKScene, toScene: SceneType, transition: SKTransition? = nil) {
        guard let scene = getScene(toScene) else { return }
        if let transtion = transition {
            scene.scaleMode = .resizeFill
            fromScene.view?.presentScene(scene, transition: transition!)
        }
            else {
            scene.scaleMode = .resizeFill
            fromScene.view?.presentScene(scene)
        }

    }
    
// MARK:ここは使いたいなぁ
    func getScene (_ sceneType: SceneType) -> SKScene? {
    switch sceneType {
    case SceneType.TopMenu:
        return TopMenu(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
//    case SceneType.Dairy:
//        return Dairy(size: CGSize(width: ScreenSize.width, height:ScreenSize.height))
    case SceneType.DreamScene:
        return DreamScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))

    case .Dairy:
//        ここ修正
        return TopMenu(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
    case .Settings:
        //        ここ修正
        return TopMenu(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        }
    }
//
    func run (_ fileName: String, onNode:SKNode) {
        if ACTPlayerStats.shared.getSound() {
        onNode.run(SKAction.playSoundFileNamed(fileName, waitForCompletion: false))
        }
    }

    func showAlert(on scene: SKScene, title: String, message: String, preferredStyle: UIAlertController.Style = .alert, actions:[UIAlertAction], animated: Bool = true, delay: Double = 0.0,  completion: (() -> Swift.Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)

        for action in actions {
            alert.addAction(action)
        }

        let wait = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: wait) {
            scene.view?.window?.rootViewController?.present(alert, animated: animated, completion: completion)
        }


    }
}

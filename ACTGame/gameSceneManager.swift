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



class gameSceneManager {
    
    static let shared = gameSceneManager()
    
    private init() {

       }
    
    public func launch() {
           firstLaunch()
       }
    
    private var dreamSceneID : Int = 0
    
    func getDreamSceneId() -> Int {
        return dreamSceneID
    }
    
    func setDreamSceneID(id : Int){
        dreamSceneID = id
    }
    
    func sleepDreamSceneId(){
        let sheep = sheepManager.shared
        dreamSceneID = sheep.getID()
    }
    
    func resetDreamSceneID(){
        dreamSceneID = 900000
    }
    
    enum SceneType: Int {
        case TopMenu, Diary, Settings, DreamScene
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
        case popupCancel = "cancelbutton.png"
        case popupOK = "okbutton.png"
        
        case drink_enabled = "drinkbutton_enabled.png"
        case drink_disabled = "drinkbutton_disabled.png"
        
        case returnbutton = "returnbutton.png"
        case backbutton = "backbutton.png"
        case forwardbutton = "forwardbutton.png"
        case diarytitlenode = "diarytitlenode.png"
        
    }
    
//    var sheepCardName : [String]{
//        get{
//            return ["sheep1.png","sheep2.png","sheep0.png","sheep0.png","sheep0.png","sheep0.png"]
//        }
//
//    }
    
    
//    初回起動時
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
    
    func getScene (_ sceneType: SceneType) -> SKScene? {
    switch sceneType {
    case SceneType.TopMenu:
        return TopMenu(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))

    case SceneType.DreamScene:
        return DreamScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))

    case .Diary:
        return DiaryScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        
    case .Settings:
        return SettingsScene(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
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

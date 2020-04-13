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

class sheepManager {
    
    var sheeps : Int = 0
    var sheepsPerTap : Int = 1
    var sheepsPerSecond : Int = 0
    var drinkUsed : Int = 0
    var areaLevel : Int = 1
    
    static var shared = sheepManager()
    
    
    private init(){}
    
    func resetSharedInstance() {
        sheeps = 0
        sheepsPerSecond = 0
        sheepsPerTap = 1
        drinkUsed = 0
        areaLevel = 1
    }
    
    func addSPT() {
        sheeps += sheepsPerTap
        print("sheeps: \(sheeps)")
    }
    
    func addSPS() {
        sheeps += sheepsPerSecond
        print("sheeps: \(sheeps)")
    }

    func increaseSPT(amount: Int){
        sheepsPerTap += amount
    }
    
    func increaseSPS(amount: Int){
        sheepsPerSecond += amount
    }
}

class gameSceneManager {
    
    enum SceneType: Int {
        case TopMenu, Dairy, Settings
    }
    enum ImageName : String {
        case sheepbutton = "sheepbutton.png"
        case sleepButton = "sleepbutton.png"
    }
    

    
//    private init() {
//
//    }
//    static let shared = gameManager()
//
//    public func launch() {
//        firstLaunch()
//    }
//
//    private func firstLaunch(){
//
//        if !UserDefaults.standard.bool(forKey: "ifFirstLaunch") {
//            print("this is our first launch")
//            ACTPlayerStats.shared.setSounds(true)
//            ACTPlayerStats.shared.saveMusicVolume(0.7)
//            UserDefaults.standard.set(true, forKey: "ifFirstLaunch")
//            UserDefaults.standard.synchronize()
//        }
//    }
//
    
//    func transition(_ fromScene: SKScene, toScene: SceneType, transition: SKTransition? = nil) {
//        guard let scene = getScene(toScene) else { return }
//
//        if let transtion = transition {
//            scene.scaleMode = .resizeFill
//            fromScene.view?.presentScene(scene, transition: transition!)
//        }
//            else {
//            scene.scaleMode = .resizeFill
//            fromScene.view?.presentScene(scene)
//        }
//
//    }
    
// MARK:ここは使いたいなぁ
//    func getScene (_ sceneType: SceneType) -> SKScene? {
//    switch sceneType {
//    case SceneType.TopMenu:
//        return TopMenu(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
////    case SceneType.Dairy:
////        return Dairy(size: CGSize(width: ScreenSize.width, height:ScreenSize.height))
//    case SceneType.Settings:

//        return Settings(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
//
//        }
//    }
////
//    func run (_ fileName: String, onNode:SKNode) {
//        if ACTPlayerStats.shared.getSound() {
//        onNode.run(SKAction.playSoundFileNamed(fileName, waitForCompletion: false))
//        }
//    }
//
//    func showAlert(on scene: SKScene, title: String, message: String, preferredStyle: UIAlertController.Style = .alert, actions:[UIAlertAction], animated: Bool = true, delay: Double = 0.0,  completion: (() -> Swift.Void)? = nil){
//        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
//
//        for action in actions {
//            alert.addAction(action)
//        }
//
//        let wait = DispatchTime.now() + delay
//        DispatchQueue.main.asyncAfter(deadline: wait) {
//            scene.view?.window?.rootViewController?.present(alert, animated: animated, completion: completion)
//        }
//
//
//    }
}

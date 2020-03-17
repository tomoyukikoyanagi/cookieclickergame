//
//  ACTManager.swift
//  AdventCalendarTutorial
//
//  Created by TomoyukiKoyanagi on 2020/03/12.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit

class ACTManager {
    
    enum SceneType: Int {
        case MainMenu, Gameplay
    }
    private init() {
        
    }
    static let shared = ACTManager()
    
    public func launch() {
        firstLaunch()
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
        
    func getScene (_ sceneType: SceneType) -> SKScene? {
    switch sceneType {
    case SceneType.MainMenu:
        return MainMenu(size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
    case SceneType.Gameplay:
        return Gameplay(size: CGSize(width: ScreenSize.width, height:
            ScreenSize.height))
    
        }
    }
    
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

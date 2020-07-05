//
//  DiaryScene.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/05/10.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class DiaryScene: SKScene {
    
    var buttonsNode : SKNode
    var sceneCam: SKCameraNode!
    var currentGroup: Int = 0
    
    override init(size: CGSize) {
        //        ここはセリフ管理クラスで作成
        buttonsNode = SKSpriteNode()
        super.init(size: size)
        //addCamera()
        addTrophiesButtons()
        setupNodes()
        addNodes()
        }

    var background: SKSpriteNode = {
        var sprite = SKSpriteNode(color: .brown, size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        sprite.zPosition = diarySceneLayer.background
        return sprite
        }()
    
    var titlelogo: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: gameSceneManager.ImageName.diarytitlenode.rawValue)
    sprite.zPosition = diarySceneLayer.titlelogo
    return sprite
    }()
    
    var titleLabel:SKLabelNode = {
        var label = SKLabelNode(fontNamed: UniversalFontName)
        label.fontSize = CGFloat.universalFont(size: 36)
        label.zPosition = diarySceneLayer.title
        label.color = SKColor.white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.text = "ゆめ日記"
        return label
    }()
    
    lazy var backButton : BDButton = {
        var button = BDButton(imageNamed: gameSceneManager.ImageName.backbutton.rawValue, buttonAction: {
            let current_x = self.buttonsNode.position.x
            let actionMove = SKAction.move(to: CGPoint(x:current_x + ScreenSize.width, y: ScreenSize.height * 0), duration: TimeInterval(0.2))
            self.currentGroup -= 1
            self.buttonsNode.run(SKAction.sequence([actionMove]))
        })
        button.zPosition = diarySceneLayer.button
        return button
    }()
    
    lazy var forwardButton : BDButton = {
        var button = BDButton(imageNamed: gameSceneManager.ImageName.forwardbutton.rawValue, buttonAction: {
            let current_x = self.buttonsNode.position.x
            let actionMove = SKAction.move(to: CGPoint(x:current_x - ScreenSize.width, y: ScreenSize.height * 0), duration: TimeInterval(0.2))
            self.currentGroup += 1
            self.buttonsNode.run(SKAction.sequence([actionMove]))
        })
        button.zPosition = diarySceneLayer.button
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
    
    func addTrophiesButtons(){
        for j in 0 ... 20{
            for i in 0 ... 4{
                var button = BDButton(imageNamed: "jisseki.png", buttonAction: {
                })
                button.position = CGPoint(x: buttonsXPosition(rowNo: j),y: ScreenSize.height * 0.7 - CGFloat(100 * i) )
                button.scaleTo(screenWithPercentage: 0.23)
                buttonsNode.addChild(button)
            }
        }
    }
    
    func buttonsXPosition(rowNo: Int) -> CGFloat{
        let group: Int = rowNo / 4
        print("group:\(group)")
        let space : CGFloat =  CGFloat(Double(group)) * ScreenSize.width * 0.2
        let rowSpace : CGFloat = CGFloat(rowNo) * ScreenSize.width * 0.2
        return ScreenSize.width * 0.2 + rowSpace + space
    }
    
    func addCamera() {
        sceneCam = SKCameraNode()
        sceneCam.setScale(1.0)
        camera = sceneCam  //set the scene's camera
        addChild(sceneCam) //add camera to scene
        //position the camera on the scene.
        sceneCam.position = CGPoint(x: ScreenSize.width / 2, y: ScreenSize.height / 2)
    }
    
    lazy var returnButton: BDButton = {
        var button = BDButton(imageNamed: gameSceneManager.ImageName.returnbutton.rawValue, buttonAction: {
            gameSceneManager.shared.transition(self, toScene: .TopMenu, transition: SKTransition.reveal(with: .down, duration: 0.3))
        })
        button.scaleTo(screenWithPercentage: 0.2)
        button.zPosition = diarySceneLayer.button
        return button
    }()
    
    func setupNodes() {
        background.position = CGPoint(x:ScreenSize.width * 0.5,y: ScreenSize.height * 0.5)
        buttonsNode.position = .zero
        returnButton.position = CGPoint(x:ScreenSize.width * 0.15,y: ScreenSize.height * 0.9)
        titleLabel.position = CGPoint(x:ScreenSize.width * 0.5, y: ScreenSize.height * 0.8)
        titlelogo.position = CGPoint(x:ScreenSize.width * 0.5, y: ScreenSize.height * 0.8)
        backButton.position = CGPoint(x:ScreenSize.width * 0.25, y: ScreenSize.height * 0.1)
        forwardButton.position = CGPoint(x:ScreenSize.width * 0.75, y: ScreenSize.height * 0.1)
    }
    
    func addNodes() {
        addChild(background)
        addChild(returnButton)
        addChild(titleLabel)
        addChild(titlelogo)
        addChild(buttonsNode)
        addChild(backButton)
        addChild(forwardButton)
    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent!) {
//        let touch = touches.first!
//        let positionInScene = touch.location(in: self.view)
//        let previousPosition = touch.previousLocation(in: self.view)
//      let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
//
//      sceneCam.position = CGPoint(x: sceneCam.position.x - translation.x, y: sceneCam.position.y - translation.y)
//    }
}

struct diarySceneLayer {
    static let background : CGFloat = 0
    static let titlelogo : CGFloat = 1
    static let title : CGFloat = 2
    static let button : CGFloat = 5
    
}


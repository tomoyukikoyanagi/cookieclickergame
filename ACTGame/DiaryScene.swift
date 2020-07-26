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
    var currentGroup: Int = 0
    let swipeRight = UISwipeGestureRecognizer()
    let swipeLeft = UISwipeGestureRecognizer()
    
    override func didMove(to view: SKView) {
        swipeRight.addTarget(self, action: (#selector(DiaryScene.swipedRight)))
        swipeRight.direction = .right
        swipeLeft.addTarget(self, action: (#selector(DiaryScene.swipedLeft)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeRight)
        view.addGestureRecognizer(swipeLeft)
    }
    
    override init(size: CGSize) {
        //        ここはセリフ管理クラスで作成
        buttonsNode = SKSpriteNode()
        super.init(size: size)
        addTrophiesButtons()
        setupNodes()
        addNodes()
        }
    
   @objc func swipedRight(sender: UISwipeGestureRecognizer){
        if self.currentGroup != 0{
            let current_x = self.buttonsNode.position.x
            let actionMove = SKAction.move(to: CGPoint(x:current_x + ScreenSize.width, y: ScreenSize.height * 0), duration: TimeInterval(0.4))
            self.currentGroup -= 1
            self.buttonsNode.run(SKAction.sequence([actionMove]))
        }
    }
    
    @objc func swipedLeft(sender: UISwipeGestureRecognizer){
        if self.currentGroup != 6{
            let current_x = self.buttonsNode.position.x
            let actionMove = SKAction.move(to: CGPoint(x:current_x - ScreenSize.width, y: ScreenSize.height * 0), duration: TimeInterval(0.4))
            self.currentGroup += 1
            self.buttonsNode.run(SKAction.sequence([actionMove]))
        }
    }

    var background: SKSpriteNode = {
        var sprite = SKSpriteNode(color: .brown, size: CGSize(width: ScreenSize.width, height: ScreenSize.height))
        sprite.zPosition = diarySceneLayer.background
        return sprite
        }()
    
    var nodeBackground: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed: "dairy_background.png")
        sprite.zPosition = diarySceneLayer.nodeBackground
        return sprite
    }()
    
    var diaryDefaultWindow: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed:"dairy_window.png")
        sprite.zPosition = diarySceneLayer.window
        sprite.scaleTo(screenWidthPercentage: 1.0)
        return sprite
    }()
    
    
    func setDairyWindow_emptyState() {
        var sprite = SKSpriteNode(imageNamed: "emptyStateImage.png")
        var titleLabel = SKLabelNode(fontNamed: UniversalFontName)
        var subTitleLabel = SKLabelNode(fontNamed: UniversalFontName)
        
        titleLabel.text = "タップして夢を確認する"
        titleLabel.fontSize = CGFloat.universalFont(size: 24)
        titleLabel.fontColor = SKColor(hue: 3, saturation: 78, brightness: 46, alpha: 100)
        
        subTitleLabel.text = "一度見た夢は思い出すことで繰り返し見ることができます¥n夢を見る条件が確認できます"
        subTitleLabel.fontSize = CGFloat.universalFont(size: 20)
        subTitleLabel.fontColor = SKColor(hue: 3, saturation: 78, brightness: 46, alpha: 100)
        
        sprite.position = CGPoint(x:0, y:0)
        titleLabel.position = CGPoint(x:0,y:100)
        subTitleLabel.position = CGPoint(x:0,y:-80)
        
        diaryDefaultWindow.addChild(sprite)
        diaryDefaultWindow.addChild(titleLabel)
        diaryDefaultWindow.addChild(subTitleLabel)
    }
    
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Error")
    }
    
    func addTrophiesButtons(){
        for j in 0 ... 9{
            for i in 0 ... 3{
                let no = i + j * 4
                let button = addDiaryNode(no: no)
                button.position = CGPoint(x: CGFloat(80 * j) + 50,y: ScreenSize.height * 0.7 - CGFloat(80 * i) )
                button.scaleTo(screenWithPercentage: 0.20)
                buttonsNode.addChild(button)
            }
        }
    }
    
    
    func addDiaryNode(no: Int) -> DiaryNode{
        let button = DiaryNode(no: no, buttonAction: {
                    self.diaryDefaultWindow.removeAllChildren()
                    let shared = sheepManager.shared
                    let dw = DiaryWindow(no: no, buttonAction: {
                        gameSceneManager.shared.setDreamSceneID(id: getNoToID(no: no))
                        gameSceneManager.shared.transition(self, toScene: .DreamScene, transition: SKTransition.fade(withDuration: 8.0)
                        )
                    })
            dw.setLabel(storyLevel: shared.getStoryLevel(), dreamArray: shared.dreamArray)
                    self.diaryDefaultWindow.addChild(dw)
                })
        return button
    }
    
    func buttonsXPosition(rowNo: Int) -> CGFloat{
        let group: Int = rowNo / 4
        print("group:\(group)")
        let space : CGFloat =  CGFloat(Double(group)) * ScreenSize.width * 0.2
        let rowSpace : CGFloat = CGFloat(rowNo) * ScreenSize.width * 0.2
        return ScreenSize.width * 0.2 + rowSpace + space
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
        titleLabel.position = CGPoint(x:ScreenSize.width * 0.5, y: ScreenSize.height * 0.85)
        titlelogo.position = CGPoint(x:ScreenSize.width * 0.5, y: ScreenSize.height * 0.85)
        diaryDefaultWindow.position = CGPoint(x:ScreenSize.width * 0.5,y: ScreenSize.height * 0.15)
    }
    
    func addNodes() {
        addChild(background)
        addChild(returnButton)
        addChild(titleLabel)
        addChild(titlelogo)
        addChild(buttonsNode)
        buttonsNode.addChild(nodeBackground)
        addChild(diaryDefaultWindow)
        setDairyWindow_emptyState()
    }
}

struct diarySceneLayer {
    static let background : CGFloat = 0
    static let titlelogo : CGFloat = 1
    static let title : CGFloat = 2
    static let nodeBackground : CGFloat = 3
    static let button : CGFloat = 5
    static let window : CGFloat = 6
}


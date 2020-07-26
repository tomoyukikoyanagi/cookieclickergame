//
//  DiaryWindow.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/07/24.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit

class DiaryWindow : SKNode {
    
    private var title : String
    private var condition : String
    private var no : Int
    var action: () -> Void
    var requieredLevel : Int
    
    
    init(no : Int, buttonAction: @escaping () -> Void){
        self.no = no
        let talkList = talkListStructList[no]
        self.title = talkList.getTitle() as! String
        self.condition = talkList.getCondition() as! String
        self.action = buttonAction
        self.requieredLevel = talkList.getStoryLevel()
        super.init()
        setupNodes()
        addNodes()
    }
    
    var dairyWindow: SKSpriteNode = {
        var sprite = SKSpriteNode(imageNamed:"dairy_window.png")
        sprite.zPosition = diarySceneLayer.window
        sprite.scaleTo(screenWidthPercentage: 1.0)
        return sprite
    }()
    
    lazy var titleLabel: SKLabelNode = {
        var titleLabel = SKLabelNode(fontNamed: UniversalFontName)
        titleLabel.fontSize = CGFloat.universalFont(size: 24)
        titleLabel.text = "No.\(self.no) \(self.title)"
        titleLabel.fontColor = SKColor(hue: 3, saturation: 78, brightness: 46, alpha: 100)
        return titleLabel
    }()
    
    lazy var subTitleLabel: SKLabelNode = {
        var subTitleLabel = SKLabelNode(fontNamed: UniversalFontName)
        subTitleLabel.text = "解放条件 : \(self.condition)"
        subTitleLabel.fontSize = CGFloat.universalFont(size: 20)
        subTitleLabel.fontColor = SKColor(hue: 3, saturation: 78, brightness: 46, alpha: 100)
        return subTitleLabel
    }()
    
    func setupNodes(){
        titleLabel.position = CGPoint(x:0,y:100)
        subTitleLabel.position = CGPoint(x:0,y:60)
    }
    
    func setLabel(storyLevel: Int, dreamArray: [Int]){
        if storyLevel < self.requieredLevel {
            setLabel_unAvalilable()
        } else if dreamArray[self.no] == 1 {
            setLabel_unLocked()
        } else {
            setLabel_unLocked()
        }
    }
    
    func setLabel_unLocked(){
        titleLabel.text = "No.\(self.no) \(self.title)"
        subTitleLabel.text = "解放条件 : \(self.condition)"
        button.enable()
    }
    
    func setLabel_Locked(){
        titleLabel.text = "No.\(self.no) ？？？？"
        subTitleLabel.text = "解放条件 : \(self.condition)"
        button.disable()
        button.setTitle(title: "まだ見ていない")
    }
    
    func setLabel_unAvalilable(){
        titleLabel.text = "この夢はまだ見ることができません"
        subTitleLabel.text = "黄金の羊が\(self.requieredLevel)匹必要です"
        button.disable()
        button.setTitle(title: "")
    }
    
    lazy var button: BDButton = {
        var button = BDButton(imageNamed: popupButtonImage1, title: "思い出す", buttonAction: {
            self.action()
        })
        button.position = CGPoint(x: 0, y:-60)
        return button
    }()
    
    func addNodes(){
        addChild(dairyWindow)
        dairyWindow.addChild(titleLabel)
        dairyWindow.addChild(subTitleLabel)
        dairyWindow.addChild(button)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  DiaryNode.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/07/24.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation
import SpriteKit



class DiaryNode: SKNode {
    
    var no : Int
    var explainText : String = ""
    var locked : Bool = true
    var levelAvailable : Bool = false
    var action:() -> Void
    
    init(no: Int, buttonAction: @escaping () -> Void) {
        self.no = no
        action = buttonAction
        super.init()
        self.levelAvailable = isAvailable()
        self.locked = isLocked()
        addNodes()
    }
    
    func isAvailable() -> Bool {
        let shared = sheepManager.shared
        if shared.getStoryLevel() >= talkListStructList[no].getStoryLevel(){
            return true
        } else {
            return false
        }
    }
    
    func isLocked() -> Bool {
        let shared = sheepManager.shared
        if shared.dreamArray[self.no] == 0{
           return true
        }
        else {
           return false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//
    func idToSheepimage(no:Int) -> Int{
        return 0
    }
    
    lazy var button: BDButton = {
        var imageName = diaryNodeImage[7]
        if self.levelAvailable == true {
            imageName = diaryNodeImage[idToSheepimage(no: self.no)]
        }
        var button = BDButton(imageNamed: imageName, title: "", buttonTitle: "", buttonAction: {
            self.action()
        })
        if self.locked == true {
            button.alpha = 0.6
        }
        return button
    }()
    
    func addNodes(){
        addChild(button)
    }
    
    func scaleTo(screenWithPercentage: CGFloat){
        button.scaleTo(screenWithPercentage: screenWithPercentage)
    }

}

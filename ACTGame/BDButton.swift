//
//  BDButton.swift
//  AdventCalendarTutorial
//
//  Created by TomoyukiKoyanagi on 2020/03/12.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import SpriteKit

class BDButton: SKNode {
    var button: SKSpriteNode
    private var mask: SKSpriteNode
    private var cropNode:SKCropNode
    private var action: () -> Void
    private var isEnabled = true
    var titleLabel: SKLabelNode?
    var buttonTitleLabel: SKLabelNode?
    
    
    init (imageNamed: String, title: String? = "", buttonTitle: String? = "", buttonAction: @escaping () -> Void){
        button = SKSpriteNode(imageNamed: imageNamed)
        titleLabel = SKLabelNode(text: title)
        buttonTitleLabel = SKLabelNode(text: buttonTitle)
        mask = SKSpriteNode(color: SKColor.black, size: button.size)
        mask.alpha = 0.0
        cropNode = SKCropNode()
        cropNode.maskNode = button
        cropNode.zPosition = 3
        cropNode.addChild(mask)
        action = buttonAction
        super.init()
        isUserInteractionEnabled = true
        setupNodes()
        addNodes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("initcoder has not been impemented")
    }
    
    func setupNodes() {
        button.zPosition = 0
        
//        text label will be set center
        if let titleLabel = titleLabel {
            titleLabel.fontName = "GenEi LateMin v2"
            titleLabel.fontSize = CGFloat.universalFont(size: 16)
            titleLabel.fontColor = SKColor.white
            titleLabel.zPosition = 1
            titleLabel.horizontalAlignmentMode = .center
            titleLabel.verticalAlignmentMode = .center
        }
        if let buttonTitleLabel = buttonTitleLabel {
            buttonTitleLabel.fontName = "GenEi LateMin v2"
            buttonTitleLabel.fontSize = CGFloat.universalFont(size: 14)
            buttonTitleLabel.fontColor = SKColor.white
            buttonTitleLabel.zPosition = 1
            buttonTitleLabel.horizontalAlignmentMode = .center
            buttonTitleLabel.verticalAlignmentMode = .center
            buttonTitleLabel.position = CGPoint(x: 0, y: -50)
        }
    }
    
    func addNodes() {
        addChild(button)
        if let titleLabel = titleLabel {
            addChild(titleLabel)
        }
        if let buttonTitleLabel = buttonTitleLabel {
            addChild(buttonTitleLabel)
        }
        addChild(cropNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnabled {
//            mask.alpha = 0.5
            run(SKAction.scale(by: 1.25, duration: 0.05))
            run(SKAction.scale(by: 0.8, duration: 0.01))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnabled {
            for touch in touches {
                let location: CGPoint = touch.location(in: self)
                if button.contains(location) {
//                    mask.alpha = 0.5
                } else {
//                    mask.alpha = 0.0
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isEnabled {
            for touch in touches {
                let location: CGPoint = touch.location(in: self)
                if button.contains(location) {
                    ACTManager.shared.run(SoundFileName.TapFile.rawValue, onNode: self)
//                    disable()
                    action()
                    run(SKAction.sequence([SKAction.wait(forDuration:  0.2), SKAction.run({self.enable()
                    })]))
                }
            }
        }
    }
    
    func disable() {
        isEnabled = false
        mask.alpha = 0.0
        button.alpha = 0.3
        titleLabel?.alpha = 0.3
        
    }
    
    func enable() {
        isEnabled = true
        mask.alpha = 0.0
        button.alpha = 1.0
        titleLabel?.alpha = 1.0
    }
    
    func logAvailableFonts() {
        for family: String in UIFont.familyNames {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print ("==\(names)")
            }
            
        }
    }
    
    func scaleTo(screenWithPercentage: CGFloat){
        let aspectRatio = button.size.height / button.size.width
        let screenWidth = ScreenSize.width
        var screenHeight = ScreenSize.height
        if DeviceType.isiPhoneX {
            screenHeight -= 80.0
        }
        button.size.width = screenWidth * screenWithPercentage
        button.size.height = button.size.width * aspectRatio
    }
    
    func changeImage(imageNamed: String){
         button = SKSpriteNode(imageNamed: imageNamed)
    }
    
    func setTitle(title: String){
        titleLabel?.text = title
    }
    
}

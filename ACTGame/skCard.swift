//
//  BDButton.swift
//  AdventCalendarTutorial
//
//  Created by TomoyukiKoyanagi on 2020/03/12.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import SpriteKit

class SKCard: SKNode {
    var card: SKSpriteNode
    private var mask: SKSpriteNode
    private var cropNode:SKCropNode
    private var action: () -> Void
    private var isEnabled = true
    
    private var level : Int
    
    var levelLabel: SKLabelNode?
    var amountLabel: SKLabelNode?
    var buttonLabel: SKLabelNode?
    
    
    init (imageNamed: String, amountTitle: String? = "", buttonTitle: String? = "", buttonAction: @escaping () -> Void){
        level = 0
        card = SKSpriteNode(imageNamed: imageNamed)
        levelLabel = SKLabelNode(text: "Lv.\(level)")
        amountLabel = SKLabelNode(text: amountTitle)
        buttonLabel = SKLabelNode(text: buttonTitle)
        mask = SKSpriteNode(color: SKColor.black, size: card.size)
        mask.alpha = 0.0
        cropNode = SKCropNode()
        cropNode.maskNode = card
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
        card.zPosition = 0
        if let levelLabel = levelLabel {
            setupLabel(label: levelLabel)
            levelLabel.position = CGPoint(x:-55, y: 118)
            levelLabel.verticalAlignmentMode = .top
            levelLabel.horizontalAlignmentMode = .left
        }
        if let amountLabel = amountLabel {
            setupLabel(label: amountLabel)
            amountLabel.position = CGPoint(x:55, y: 118)
            amountLabel.verticalAlignmentMode = .top
            amountLabel.horizontalAlignmentMode = .right
            
        }
        if let buttonLabel = buttonLabel {
            setupLabel(label: buttonLabel)
            buttonLabel.position = CGPoint(x:0, y: -110)
            buttonLabel.horizontalAlignmentMode = .center
            buttonLabel.verticalAlignmentMode = .bottom
        }
    }
    
    func setupLabel(label: SKLabelNode){
        label.fontName = "****"
        label.fontSize = CGFloat.universalFont(size: 20)
        label.fontColor = SKColor.white
        label.zPosition = 1
    }
    
    func addNodes() {
        addChild(card)
        if let levelLabel = levelLabel {
            addChild(levelLabel)
        }
        if let amountLabel = amountLabel {
            addChild(amountLabel)
        }
        if let buttonLabel = buttonLabel {
            addChild(buttonLabel)
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
                if card.contains(location) {
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
                if card.contains(location) {
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
        card.alpha = 0.3
    }
    
    func enable() {
        isEnabled = true
        mask.alpha = 0.0
        card.alpha = 1.0
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
        let aspectRatio = card.size.height / card.size.width
        let screenWidth = ScreenSize.width
        var screenHeight = ScreenSize.height
        if DeviceType.isiPhoneX {
            screenHeight -= 80.0
        }
        card.size.width = screenWidth * screenWithPercentage
        card.size.height = card.size.width * aspectRatio
    }
    
    func changeImage(imageNamed: String){
         card = SKSpriteNode(imageNamed: imageNamed)
    }
    
    func changeLevelLabel(addLevel: Int){
        level += addLevel
        levelLabel?.text = "Lv.\(level)"
        amountLabel?.text = "\(coridale.addSPS[level - 1])"
        buttonLabel?.text = "\(coridale.price[level - 1])"
        if level == 10{
            buttonLabel?.text = "レベル最大"
        }
    }
    
    func getPrice() -> Int{
        let price = buttonLabel?.text ?? "0"
        return Int(price) ?? 0
    }
}


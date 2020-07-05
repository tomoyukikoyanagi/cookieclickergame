//
//  BDButton.swift
//  AdventCalendarTutorial
//
//  Created by TomoyukiKoyanagi on 2020/03/12.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import SpriteKit

class DrinkButton: SKNode {
    var button: SKSpriteNode
    private var mask: SKSpriteNode
    private var cropNode:SKCropNode
    private var action: () -> Void
    private var isEnabled = true
    var drinkLeftLabel: SKLabelNode?
    var nameLabel: SKLabelNode?

    init (buttonAction: @escaping () -> Void){
        button = SKSpriteNode(imageNamed: gameSceneManager.ImageName.drink_disabled.rawValue)
        drinkLeftLabel = SKLabelNode(text: "0")
        nameLabel = SKLabelNode(text: "")
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
        
        self.updateDrinkLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("initcoder has not been impemented")
    }
    
    func setupNodes() {
        button.zPosition = 0
        if let nameLabel = nameLabel {
            setupLabel(label: nameLabel)
            nameLabel.position = CGPoint(x:0, y: -35)
            nameLabel.verticalAlignmentMode = .center
            nameLabel.horizontalAlignmentMode = .center
        }
        if let drinkLeftLabel = drinkLeftLabel {
            setupLabel(label: drinkLeftLabel)
            drinkLeftLabel.position = CGPoint(x:25, y: 35)
            drinkLeftLabel.verticalAlignmentMode = .center
            drinkLeftLabel.horizontalAlignmentMode = .left

        }
    }
    
    func setupLabel(label: SKLabelNode){
        label.fontName = "****"
        label.fontSize = CGFloat.universalFont(size: 18)
        label.fontColor = SKColor.white
        label.zPosition = 1
    }

    func addNodes() {
        addChild(button)
        if let nameLabel = nameLabel{
            addChild(nameLabel)
        }
        if let drinkLeftLabel = drinkLeftLabel {
            addChild(drinkLeftLabel)
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
                    let sharedInstance = sheepManager.shared
                    sharedInstance.useDrink()
                    ACTManager.shared.run(SoundFileName.TapFile.rawValue, onNode: self)
//                    disable()
                    action()
                    updateDrinkLabel()
//                    run(SKAction.sequence([SKAction.wait(forDuration:  drinkModeTime), SKAction.run({self.enable()
//                    })]))
                }
            }
        }
    }
    
    func disable() {
        isEnabled = false
        mask.alpha = 0.5
        button.texture = SKTexture(imageNamed: gameSceneManager.ImageName.drink_disabled.rawValue)
    }
    
    func enable() {
        isEnabled = true
        mask.alpha = 0.0
        button.texture = SKTexture(imageNamed: gameSceneManager.ImageName.drink_enabled.rawValue)
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
    
    func updateDrinkLabel(){
        let sharedInstance = sheepManager.shared
        drinkLeftLabel?.text = "\(String(describing: sharedInstance.getDrinkPossessed()))"
        if sharedInstance.getDrinkPossessed() > 0 {
            self.enable()
        } else {
            self.disable()
        }
    }

    
    
}



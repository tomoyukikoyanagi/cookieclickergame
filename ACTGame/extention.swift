//
//  extention.swift
//  AdventCalendarTutorial
//
//  Created by TomoyukiKoyanagi on 2020/03/12.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import UIKit
import SpriteKit

let UniversalFontName = "GenEi LateMin v2"

enum UIUserInterfaceIdiom: Int {
    case undefined
    case phone
    case pad

}

struct ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxheight = max(ScreenSize.width, ScreenSize.height)
    static let minheight = min(ScreenSize.width, ScreenSize.height)
}

struct DeviceType {
    static let isiPhone4OrLess = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxheight < 568.0
    static let isiPhone5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxheight == 568.0
    static let isiPhone6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxheight == 667.0
    static let isiPhone6Plus = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxheight == 736.0
    static let isiPhoneX = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxheight == 812.0
    static let isiPad = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxheight == 1024.0
    static let isiPadPro = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxheight == 1366.0
}

public extension CGFloat {
    public static func universalFont(size: CGFloat) -> CGFloat {
        if DeviceType.isiPhone4OrLess {
            return size * 0.6
        }
        
        if DeviceType.isiPhone5 {
            return size * 0.8
        }
        
        if DeviceType.isiPhone6 {
            return size * 1.0
        }
        
        if DeviceType.isiPhoneX {
            return size * 1.0
        }
        
        if DeviceType.isiPad {
            return size * 2.1
        }
        else {
            return size * 1.0
        }
       
    }
}

extension SKSpriteNode {
    func scaleTo(screenWidthPercentage: CGFloat) {
        let aspectRatio = self.size.height / self.size.width
        self.size.width = ScreenSize.width * screenWidthPercentage
        self.size.height = self.size.width * aspectRatio
    }
    
    func scaleTo(screenHeightPercentage: CGFloat) {
        let aspectRatio = self.size.width / self.size.height
        self.size.width = ScreenSize.width * screenHeightPercentage
        self.size.height = self.size.height * aspectRatio
    }
    
   
  func popUp(after: CGFloat = 0.0, sequenceNumber: Int = 1) {
    let action2Duration = 0.2
    let action3Duration = 0.06
    let action4Duration = 0.1
    let action5Duration = 0.05
    let totalTimeOfPopUpAnimation = action2Duration + action3Duration + action4Duration + action5Duration
    let action0 = SKAction.scale(to: 0.0, duration: 0.0)
    let action1 = SKAction.wait(forDuration: TimeInterval(CGFloat(sequenceNumber) * CGFloat(totalTimeOfPopUpAnimation) + after))
    let action2 = SKAction.scale(to: 1.1, duration: action2Duration)
    let action3 = SKAction.scale(to: 0.95, duration: action3Duration)
    let action4 = SKAction.scale(to: 1.05, duration: action4Duration)
    let action5 = SKAction.scale(to: 1.0, duration: action5Duration)
    let sequence = SKAction.sequence([action0, action1, action2, action3, action4, action5])
    self.run(sequence)
  }
  
  func popDown(after: CGFloat = 0.0, sequenceNumber: Int = 1) {
    let action2Duration = 0.1
    let action3Duration = 0.03
    let action4Duration = 0.05
    let action5Duration = 0.02
    let totalTimeOfPopUpAnimation = action2Duration + action3Duration + action4Duration + action5Duration
    let action0 = SKAction.scale(to: 1.0, duration: 0.0)
    let action1 = SKAction.wait(forDuration: TimeInterval(CGFloat(sequenceNumber) * CGFloat(totalTimeOfPopUpAnimation) + after))
    let action2 = SKAction.scale(to: 1.9, duration: action2Duration)
    let action3 = SKAction.scale(to: 1.7, duration: action3Duration)
    let action4 = SKAction.scale(to: 1.85, duration: action4Duration)
    let action5 = SKAction.scale(to: 0.0, duration: action5Duration)
    let sequence = SKAction.sequence([action0, action1, action2, action3, action4, action5])
    self.run(sequence)
  }
  
  func bounce() {
    let action2Duration = 0.3
    let action3Duration = 0.12
    let action4Duration = 0.2
    let action5Duration = 0.1
    let action2 = SKAction.scale(to: 1.2, duration: action2Duration)
    let action3 = SKAction.scale(to: 0.95, duration: action3Duration)
    let action4 = SKAction.scale(to: 1.1, duration: action4Duration)
    let action5 = SKAction.scale(to: 1.0, duration: action5Duration)
    let sequence = SKAction.sequence([action2, action3, action4, action5])
    self.run(sequence)
  }
  
  func bounceLockedButton() {
    let action2Duration = 0.15
    let action3Duration = 0.06
    let action4Duration = 0.1
    let action5Duration = 0.05
    let action2 = SKAction.scale(to: 1.2, duration: action2Duration)
    let action3 = SKAction.scale(to: 0.95, duration: action3Duration)
    let action4 = SKAction.scale(to: 1.1, duration: action4Duration)
    let action5 = SKAction.scale(to: 1.0, duration: action5Duration)
    let sequence = SKAction.sequence([action2, action3, action4, action5])
    self.run(sequence)
  }
  
  func bounceCookie() {
    let action2Duration = 0.3
    let action3Duration = 0.12
    let action4Duration = 0.2
    let action5Duration = 0.1
    let action2 = SKAction.scale(to: 1.6, duration: action2Duration)
    let action3 = SKAction.scale(to: 0.95, duration: action3Duration)
    let action4 = SKAction.scale(to: 1.3, duration: action4Duration)
    let action5 = SKAction.scale(to: 1.0, duration: action5Duration)
    let sequence = SKAction.sequence([action2, action3, action4, action5])
    self.run(sequence)
  }
  
  func rotate(speed: Int, clockWise: Bool) {
    let angel = clockWise ? CGFloat(-.pi/2.0) : CGFloat(.pi/2.0)
    let rotateForever = SKAction.repeatForever(SKAction.rotate(byAngle: angel, duration: TimeInterval(speed)))
    self.run(rotateForever)
  }
  
  func swing(speed: Int, startClockWise: Bool, angle: CGFloat) {
    let swingRight = SKAction.rotate(toAngle: .pi/angle, duration: TimeInterval(speed))
    let swingLeft = SKAction.rotate(toAngle: -.pi/angle, duration: TimeInterval(speed))
    let sequence = startClockWise ? SKAction.sequence([swingRight, swingLeft]) : SKAction.sequence([swingLeft, swingRight])
    let swingForever = SKAction.repeatForever(sequence)
    self.run(swingForever)
  }
  
  func slide(speed: Int, distanceX: CGFloat, distanceY: CGFloat) {
    let slide = SKAction.moveBy(x: distanceX , y: distanceY, duration: TimeInterval(speed))
    let slideBack = SKAction.moveBy(x: -distanceX , y: -distanceY, duration: TimeInterval(speed))
    let slideLeftRight = SKAction.sequence([slide, slideBack])
    let slideForever = SKAction.repeatForever(slideLeftRight)
    self.run(slideForever)
  }
  
  func fadeUp() {
    let randomWait = SKAction.wait(forDuration: TimeInterval(CGFloat.random(in: 0.0 ... 0.2)))
    let growAction = SKAction.scale(to: CGFloat.random(in: 3.0 ... 5.0), duration: TimeInterval(CGFloat.random(in: 1.0 ... 1.5)))
    let fadeOutAction = SKAction.fadeOut(withDuration: TimeInterval(CGFloat.random(in: 1.0 ... 1.5)))
    let group = SKAction.group([growAction, fadeOutAction])
    self.run(SKAction.sequence([randomWait, group]))
  }
}

extension SKLabelNode {
  func popUp(after: CGFloat = 0.0, sequenceNumber: Int = 1) {
    let action2Duration = 0.2
    let action3Duration = 0.06
    let action4Duration = 0.1
    let action5Duration = 0.05
    let totalTimeOfPopUpAnimation = action2Duration + action3Duration + action4Duration + action5Duration
    let action0 = SKAction.scale(to: 0.0, duration: 0.0)
    let action1 = SKAction.wait(forDuration: TimeInterval(CGFloat(sequenceNumber) * CGFloat(totalTimeOfPopUpAnimation) + after))
    let action2 = SKAction.scale(to: 1.1, duration: action2Duration)
    let action3 = SKAction.scale(to: 0.95, duration: action3Duration)
    let action4 = SKAction.scale(to: 1.05, duration: action4Duration)
    let action5 = SKAction.scale(to: 1.0, duration: action5Duration)
    let sequence = SKAction.sequence([action0, action1, action2, action3, action4, action5])
    self.run(sequence)
  }
}

extension Array where Element: Comparable {
    func everyElementIsLager(as other: [Element]) -> Bool {
        var element = 0
        if self.count == other.count {
            for i in 0 ..< self.count {
                if self[i] > other[i] {
                    element += 1
                }
            }
        }
        if element <= self.count {
            return true
        } else {
            return false
        }
    }
}

extension Notification.Name {
    static let notifyName = Notification.Name("notifyName")
    static let notifyPopup = Notification.Name("notifyPopup")
    static let notifyFukidashi = Notification.Name("notifyFukidashi")
}

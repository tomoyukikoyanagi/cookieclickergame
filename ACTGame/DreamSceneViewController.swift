//
//  DreamSceneViewController.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/05/05.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import UIKit
import LTMorphingLabel

class DreamSceneViewController: UIViewController,UIGestureRecognizerDelegate {
    
    var label: UILabel = UILabel()
    
    private let textList = ["シンプルであることは、", "複雑であることよりも", "難しい"]
    var count = 0
    

    override func viewDidLoad() {
        self.view.backgroundColor = .white
        super.viewDidLoad()
        
        label.text = textList[0]
        label.frame = CGRect(x: ScreenSize.width/4, y: 0, width: ScreenSize.width/2, height: ScreenSize.height/2)
        label.textAlignment = .left
        
        self.view.addSubview(label)
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(DreamSceneViewController.tapped(_:)))
        
        // デリゲートをセット
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer){
        if sender.state == .ended {
            count += 1
            label.text = textList[count]
            print("タップ")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

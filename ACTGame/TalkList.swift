//
//  TalkList.swift
//  ACTGame
//
//  Created by TomoyukiKoyanagi on 2020/05/05.
//  Copyright © 2020 TomoyukiKoyanagi. All rights reserved.
//

import Foundation

struct talkListStruct : Hashable{
    private var storyLevel : Int
    private var talkList : [String]
    private var id : Int
    private var no : Int
    private var character : AtlasName
    private var title : String
    private var condition : String
    
    init (title: String, condition: String, id: Int, no:Int, storyLevel: Int, character : AtlasName, talkList: [String]){
        self.title = title
        self.condition = condition
        self.character = character
        self.id = id
        self.no = no
        self.storyLevel = storyLevel
        self.talkList = talkList
    }
    
    func getID() -> Int {
        return id
    }
    
    func getNo() -> Int {
        return no
    }
    
    func getTalkList() -> [String] {
        return talkList
    }
    
    func getCharacter() -> AtlasName {
        return character
    }
    
    func getStoryLevel() -> Int{
        return storyLevel
    }
    
    func getTitle() -> String{
        return title
    }
    
    func getCondition() -> String{
        return condition
    }
}

func getTalkListID(sheep: sheepManager) -> Int{
    
    switch sheep.countMode {
    case .normal:
        return getID(storyLevel: sheep.getStoryLevel(), sheep: sheep.sheeps, drinkUsed: sheep.drinkUsed, areaNo: sheep.getCurrentAreaNumber(), levels: sheep.sheepLevelArray)
    case .dog:
        return getDogID(sheep: sheep.sheeps, areaNo: sheep.getCurrentAreaNumber())
    case.wolf:
        return getWolfID(sheep: sheep.sheeps, areaNo: sheep.getCurrentAreaNumber())
    default:
            return 90000
        }
    
    }

    
func getID(storyLevel: Int, sheep: Int, drinkUsed: Int, areaNo: Int, levels: [Int]) -> Int {
        
        let i6 = 1 * 100000
        let i5 = 0
        let i4 = storyLevel * 1000
        var i3 = 0
        var i2 = 0
        var i1 = 0
        if i4 != 0 {
            
            i3 = getSheepAmount(sheep: sheep)

            i2 = getDrinkUsed(drinkUsed: drinkUsed) * 10
            
            i1 = sheepLevelMax(levels: levels)
            
        }
        return i6 + i5 + i4 + i3 + i2
    }
    
    func getDogID(sheep: Int, areaNo:Int) -> Int {
        let i6 = 3 * 100000
        var i2 = 0
        if areaNo <= 2 {
            i2 = 0
        } else if areaNo == 3 {
            i2 = 1
        } else if areaNo >= 4 {
            i2 = 2
        }
        
        var i3 = 0
        if sheep <= THRESHOLD1 { i3 = 100 }
        else if sheep <= THRESHOLD2 { i3 = 200 }
        else if sheep <= THRESHOLD3 { i3 = 300 }
        else if sheep <= THRESHOLD6 { i3 = 400 }
        
        return i6 + i2 + i3
    }
    
    func getWolfID(sheep: Int, areaNo:Int) -> Int {
        let i6 = 5 * 100000
        
        var i1 = 0
        if sheep <= -1 * THRESHOLD4 { i1 = 1 }
        else if sheep <= -1 * THRESHOLD3 { i1 = 2 }
        else if sheep <= -1 * THRESHOLD2 { i1 = 3 }
        else if sheep <= -1 * THRESHOLD1 { i1 = 4 }
        else if sheep <= THRESHOLD1 { i1 = 5 }
        else if sheep <= THRESHOLD2 { i1 = 6 }
        else if sheep <= THRESHOLD3 { i1 = 7 }
        else if sheep <= THRESHOLD4 { i1 = 8 }
        
        return i6 + i1
    }
    
    func getSheepAmount(sheep: Int) -> Int {
        var i = 0
        if sheep <= THRESHOLD2 {i = 0}
        else if sheep <= THRESHOLD3 {i = 1}
        else if sheep <= THRESHOLD4 {i = 2}
        else if sheep <= THRESHOLD5 {i = 3}
        else if sheep <= THRESHOLD6 {i = 4}
        return i
    }
    
func sheepLevelMax(levels: [Int]) -> Int {
        if levels[6] == 10 {
            return 7
        } else if levels[5] == 10 {
            return 6
        } else if levels[4] == 10 {
            return 5
        } else if levels[3] == 10 {
            return 4
        } else if levels[2] == 10 {
            return 3
        } else if levels[1] == 10 {
            return 2
        } else if levels[0] == 10 {
            return 1
        } else {
            return 0
        }
    }

func getDrinkUsed(drinkUsed : Int) -> Int {
        if drinkUsed == 1 {
            return 1
        } else if drinkUsed <= 2 {
            return 2
        } else {
            return 0
        }
    }
    
func getTalkList(id: Int) -> talkListStruct{
    let filtered = talkListStructList.filter{ $0.getID() >= id }
    for i in 0...filtered.count - 1 {
        print(filtered[i].getID())
    }
    return filtered[0]
    }
    
func getNoToID(no: Int) -> Int{
    let talkListStruct = talkListStructList[no]
    return talkListStruct.getID()
}
    

let sheepMan0 : talkListStruct  = talkListStruct(title:"この夢ははじまりにすぎない", condition:"初めて夢を見る", id: 100000, no:0 ,storyLevel: 0, character: .sheepMan, talkList: ["はじめまして",
                                                                                                                                         "この夢を見たということは君は",
                                                                                                                                         "どんな夢でも叶えることができる夢の話を聞いたのだな",
                                                                                                                                         "で、私が夢を叶えてくれるのかって？",
                                                                                                                                          "私はただの羊男だよ。人違いだな。",
                                                                                                                                         "いや、この場合は羊違いと言ったところか？まあ気にするな",
                                                                                                                                         "どんな夢も叶える夢を見るためにはまずは",
                                                                                                                                         "七匹の黄金の羊を捕まえなくてはならない",
                                                                                                                                         "黄金の羊は君の夢の中に解き放たれている",
                                                                                                                                         "不思議な力を持った羊たちだ",
                                                                                                                                         "黄金の羊を探し出したければそれ相応にたくさんの夢を見なければならない",
                                                                                                                                         "たくさんの夢を見るためには数えた羊の数だけじゃなく",
                                                                                                                                         "どうやって羊たちを数えたかも重要になってくる",
                                                                                                                                         "迷ったらゆめ日記を読みなさい。ヒントはそこにある。",
                                                                                                                                         "あと広告もまじってる。が、それは許してくれ。",
                                                                                                                                         "この夢はほんのはじまりにすぎない",
                                                                                                                                         "黄金の羊を探す長い夢の旅はこれから始まるんだ"]
)

let sheepMan1 : talkListStruct = talkListStruct(title:"疲れているのか？", condition:"初めて夢を見る", id: 110100, no:1, storyLevel: 1, character: .sheepMan, talkList: ["...",
                                                                                                                                                       "お前羊数える気ないだろ？",
                                                                                                                                                       "あるいは本当に疲れてるのか？",
                                                                                                                                                       "もし疲れているのなら栄養ドリンクを使うことをお勧めしよう",
                                                                                                                                                       "栄養ドリンクは強化メニューから買うことができるぞ",
                                                                                                                                                       "ただし、栄養ドリンクを使うには夢のかけらが必要だ",
                                                                                                                                                       "あるいは広告を見てもらうこともできる"
                                                                                                                                                ])
let sheepMan2 : talkListStruct = talkListStruct(title:"羊は多いに越したことはない", condition:"初めて夢を見る", id: 110110, no: 2 , storyLevel: 1, character: .sheepMan, talkList: ["やあ。また会ったな。",
"羊を数えるのは大変か？",
"それも慣れてくれば数える効率も上がってくるぞ",
"強化メニューは使っているか？",
"羊をレベルアップすれば数えられる羊の数が増えるんだ",
"それにもしからしたら羊のレベルが見る夢に影響を与えるかもしれない",
"たくさんの羊を数えるには必須だと思うぞ"
])


let sheepMan3 : talkListStruct = talkListStruct(title:"もっと頑張れ", condition:"初めて夢を見る", id: 110200, no: 3 , storyLevel: 1, character: .sheepMan, talkList: ["お前本気か？",
"ドリンクを飲んだみたいだな",
"夢のかけらを使って買えるものは他にもあるらしい",
"だが今は買えないかもしれない",
"匹数えた程度で満足してらないないな"])


let sheepMan4 : talkListStruct = talkListStruct(title:"羊は多いに越したことはない", condition:"初めて夢を見る", id: 110210, no:4, storyLevel: 1, character: .sheepMan, talkList: ["羊に数え慣れてくると",
"羊のレベルが上がるのはもうわかっているな？",
"よりたくさんの羊を数えたければ、羊のレベル上げは大切だ",
"だが、羊の数だけで見る夢が決まるはずもまないよな",
"どのように羊を数えたかも夢に作用する",
"あと目覚めてからがっかりされても困るから先に言っとくと",
"寝ると羊のレベルはリセットされるから"])

let sheepMan5 : talkListStruct = talkListStruct(title:"羊は多いに越したことはない", condition:"初めて夢を見る", id: 120300, no:5, storyLevel: 1, character: .sheepMan, talkList: ["時にお前が実現したい夢はどんな夢だ？",
"お金が欲しい？",
"有名人が欲しい？",
"彼女が欲しい？"
])

let sheepMan6 : talkListStruct = talkListStruct(title:"何のために夢を見る？", condition:"初めて夢を見る", id: 120301, no:6, storyLevel: 1, character: .sheepMan, talkList: ["sheepman6",
"お金が欲しい？",
"有名人が欲しい？",
"彼女が欲しい？"
])

let sheepMan7 : talkListStruct = talkListStruct(title:"何のために夢を見る？", condition:"初めて夢を見る", id: 120400, no:7, storyLevel: 1, character: .sheepMan, talkList: ["sheepman7",
"お金が欲しい？",
"有名人が欲しい？",
"彼女が欲しい？"
])

let sheepMan8 : talkListStruct = talkListStruct(title:"何のために夢を見る？", condition:"初めて夢を見る", id: 120401, no:8, storyLevel: 1, character: .sheepMan, talkList: ["sheepman8",
"お金が欲しい？",
"有名人が欲しい？",
"彼女が欲しい？"
])

let sheepMan9 : talkListStruct = talkListStruct(title:"何のために夢を見る？", condition:"初めて夢を見る", id: 120000, no:9, storyLevel: 1, character: .sheepMan, talkList: ["sheepman9",
"お金が欲しい？",
"有名人が欲しい？",
"彼女が欲しい？"
])

let sheepGirl0 : talkListStruct = talkListStruct(title:"羊娘現る", condition:"山で初めて夢を見る", id: 111000, no:10, storyLevel: 1, character: .sheepGirl, talkList: ["やっほー",
"てか、あんただれ？","やばいんだけど笑", "え、ウチ？ウチは羊娘"])

let sheepGirl1 : talkListStruct = talkListStruct(title:"羊娘現る", condition:"山で初めて夢を見る", id: 121100, no:11, storyLevel: 2, character: .sheepGirl, talkList: ["loaded sheepgirl_1",
"「ひつじおとこ」ってどんなやつかって？","あいつジジくさくなーい？"])

let sheepGirl2 : talkListStruct = talkListStruct(title:"羊娘現る", condition:"山で初めて夢を見る", id: 121102, no:12, storyLevel: 2, character: .sheepGirl, talkList: ["loaded sheepgirl_2",
"開発者に報告してくれ"])

let sheepGirl3 : talkListStruct = talkListStruct(title:"羊娘現る", condition:"山で初めて夢を見る", id: 121200, no:13, storyLevel: 2, character: .sheepGirl, talkList: ["loaded sheepgirl_3",
"開発者に報告してくれ"])

let sheepGirl4: talkListStruct = talkListStruct(title:"羊娘現る", condition:"山で初めて夢を見る", id: 121202, no:14, storyLevel: 2, character: .sheepGirl, talkList: ["loaded sheepgirl_3",
"開発者に報告してくれ"])

let sheepGirl5 : talkListStruct = talkListStruct(title:"羊娘現る", condition:"山で初めて夢を見る", id: 121300, no:15, storyLevel: 2, character: .sheepGirl, talkList: ["loaded sheepgirl_5",
"開発者に報告してね"])

let sheepGirl6 : talkListStruct = talkListStruct(title:"羊娘現る", condition:"山で初めて夢を見る", id: 121302, no:16, storyLevel: 2, character: .sheepGirl, talkList: ["loaded sheepgirl_3",
"開発者に報告してくれ"])

let sheepGirl7: talkListStruct = talkListStruct(title:"羊娘現る", condition:"山で初めて夢を見る", id: 121400, no:17, storyLevel: 2, character: .sheepGirl, talkList: ["loaded sheepgirl_3",
"開発者に報告してくれ"])

let sheepGirl8: talkListStruct = talkListStruct(title:"羊娘現る", condition:"山で初めて夢を見る", id: 121402, no:18, storyLevel: 2, character: .sheepGirl, talkList: ["loaded sheepgirl_3",
"開発者に報告してくれ"])

let sheepGirl9 : talkListStruct = talkListStruct(title:"羊娘現る", condition:"山で初めて夢を見る", id: 121000, no:19, storyLevel: 2, character: .sheepGirl, talkList: ["sheepgirl9",
"開発者に報告してくれ"])

let drSheep0: talkListStruct = talkListStruct(title:"羊娘現る", condition:"山で初めて夢を見る", id: 122000, no:20, storyLevel: 2, character: .sheepGirl, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])

let drSheep1: talkListStruct = talkListStruct(title:"羊博士の講義", condition:"街で初めて夢を見る", id: 132000, no:21, storyLevel: 3, character: .drSheep, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])

let drSheep2: talkListStruct = talkListStruct(title:"羊博士の講義", condition:"街で初めて夢を見る", id: 132100, no:22, storyLevel: 3, character: .drSheep, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])

let drSheep3: talkListStruct = talkListStruct(title:"羊博士の講義", condition:"街で初めて夢を見る", id: 132103, no:23, storyLevel: 3, character: .drSheep, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])

let drSheep4: talkListStruct = talkListStruct(title:"羊博士の講義", condition:"街で初めて夢を見る", id: 132200, no:24, storyLevel: 3, character: .drSheep, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])

let drSheep5: talkListStruct = talkListStruct(title:"羊博士の講義", condition:"街で初めて夢を見る", id: 132203, no:25, storyLevel: 3, character: .drSheep, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])

let drSheep6: talkListStruct = talkListStruct(title:"羊博士の講義", condition:"街で初めて夢を見る", id: 132300, no:26, storyLevel: 3, character: .drSheep, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])

let drSheep7: talkListStruct = talkListStruct(title:"羊博士の講義", condition:"街で初めて夢を見る", id: 132303, no:27, storyLevel: 3, character: .drSheep, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])

let drSheep8: talkListStruct = talkListStruct(title:"羊博士の講義", condition:"街で初めて夢を見る", id: 132400, no:28, storyLevel: 3, character: .drSheep, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])

let drSheep9: talkListStruct = talkListStruct(title:"羊博士の講義", condition:"街で初めて夢を見る", id: 132403, no:29, storyLevel: 3, character: .drSheep, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])

let dog0: talkListStruct = talkListStruct(title:"僕が来たから大丈夫", condition:"牧羊犬を解放した状態で初めてゆめをみる", id: 330000, no:30, storyLevel: 3, character: .drSheep, talkList: ["dog0",
"開発者に報告してくれ"])



let dog1: talkListStruct = talkListStruct(title:"僕が来たから大丈夫", condition:"牧羊犬を解放した状態で初めてゆめをみる", id: 330100, no:31, storyLevel: 3, character: .drSheep, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])

let dog2: talkListStruct = talkListStruct(title:"僕が来たから大丈夫", condition:"牧羊犬を解放した状態で初めてゆめをみる", id: 330200, no:32, storyLevel: 3, character: .drSheep, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])

let dog3: talkListStruct = talkListStruct(title:"僕が来たから大丈夫", condition:"牧羊犬を解放した状態で初めてゆめをみる", id: 330300, no:33, storyLevel: 3, character: .drSheep, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])

let dog4: talkListStruct = talkListStruct(title:"僕が来たから大丈夫", condition:"牧羊犬を解放した状態で初めてゆめをみる", id: 330400, no:34, storyLevel: 3, character: .drSheep, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])

let dog5: talkListStruct = talkListStruct(title:"僕が来たから大丈夫", condition:"牧羊犬を解放した状態で初めてゆめをみる", id: 330210, no:35, storyLevel: 3, character: .drSheep, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])

let dog6: talkListStruct = talkListStruct(title:"僕が来たから大丈夫", condition:"牧羊犬を解放した状態で初めてゆめをみる", id: 330310, no:36, storyLevel: 3, character: .drSheep, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])

let dog7: talkListStruct = talkListStruct(title:"僕が来たから大丈夫", condition:"牧羊犬を解放した状態で初めてゆめをみる", id: 330410, no:37, storyLevel: 3, character: .drSheep, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])

let dog8: talkListStruct = talkListStruct(title:"僕が来たから大丈夫", condition:"牧羊犬を解放した状態で初めてゆめをみる", id: 330320, no:38, storyLevel: 3, character: .drSheep, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])

let dog9: talkListStruct = talkListStruct(title:"僕が来たから大丈夫", condition:"牧羊犬を解放した状態で初めてゆめをみる", id: 330420, no:39, storyLevel: 3, character: .drSheep, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])


let defaultTalkList : talkListStruct = talkListStruct(title:"defalt", condition:"default", id: 900000, no:99, storyLevel: 0, character: .sheepMan, talkList: ["この夢は本来は見られないはずのものだ",
"開発者に報告してくれ"])


let talkListStructList : [talkListStruct] = [
sheepMan0,
sheepMan1,
sheepMan2,
sheepMan3,
sheepMan4,
sheepMan5,
sheepMan6,
sheepMan7,
sheepMan8,
sheepMan9,
sheepGirl0,
sheepGirl1,
sheepGirl2,
sheepGirl3,
sheepGirl4,
sheepGirl5,
sheepGirl6,
sheepGirl7,
sheepGirl8,
sheepGirl9,
drSheep0,
drSheep1,
drSheep2,
drSheep3,
drSheep4,
drSheep5,
drSheep6,
drSheep7,
drSheep8,
drSheep9,
dog0,
dog1,
dog2,
dog3,
dog4,
dog5,
dog6,
dog7,
dog8,
dog9
]

//                                                   900000 : defaultTalkList,
//
//                                                   100000 : sheepMan0,
////                                                   level1
//                                                   110100 : sheepMan1,
//                                                   110110 : sheepMan2,
//                                                   110200 : sheepMan3,
//                                                   110210 : sheepMan2,
//                                                   110300 : sheepMan4,
//                                                   111000 : sheepGirl0,
////                                                   level2
//                                                   120000 : sheepMan9,
//                                                   120300 : sheepMan5,
//                                                   120301 : sheepMan6,
//                                                   120400 : sheepMan7,
//                                                   120401 : sheepMan8,
//                                                   121100 : sheepGirl1,
//                                                   121102 : sheepGirl2,
//                                                   121200 : sheepGirl3,
//                                                   121202 : sheepGirl4,
//                                                   121300 : sheepGirl5,
//                                                   121302 : sheepGirl6,
//                                                   121400 : sheepGirl7,
//                                                   121402 : sheepGirl8,
//                                                   121000 : sheepGirl9,
//                                                   122000 : drSheep0,
////                                                   level3
//                                                   132000 : drSheep1,
//                                                   132100 : drSheep2,
//                                                   132103 : drSheep3,
//                                                   132200 : drSheep4,
//                                                   132203 : drSheep5,
//                                                   132300 : drSheep6,
//                                                   132303 : drSheep7,
//                                                   132400 : drSheep8,
//                                                   132403 : drSheep9,
//                                                   330000 : dog0,
//                                                   330100 : dog1,
//                                                   330200 : dog2,
//                                                   330300 : dog3,
//                                                   330400 : dog4,
//                                                   330210 : dog5,
//                                                   330310 : dog6,
//                                                   330410 : dog7,
//                                                   330320 : dog8,
//                                                   330420 : dog9




//let talkListAchievedDictionary : [talkListStruct : Int] = [sheepMan0 : 0,
//                                                           sheepMan1 : 1,
//                                                           sheepMan2 : 2,
//                                                           sheepMan3 : 3,
//                                                           sheepMan4 : 4]

//let talkListIDDictionary : [Int : talkListStruct] = [0 : sheepMan0,
//                                                     1 : sheepMan1,
//                                                     2 : sheepMan2,
//                                                     3 : sheepMan3,
//                                                     4 : sheepMan4,
//                                                     5 : sheepMan5,
//                                                     6 : sheepMan6,
//                                                     7 : sheepMan7,
//                                                     8 : sheepMan8,
//                                                     9 : sheepMan9,
//                                                     10 : sheepGirl0,
//                                                     11 : sheepGirl1,
//                                                     12 : sheepGirl2,
//                                                     13 : sheepGirl3,
//                                                     14 : sheepGirl4,
//                                                     15 : sheepGirl5,
//                                                     16 : sheepGirl6,
//                                                     17 : sheepGirl7,
//                                                     18 : sheepGirl8,
//                                                     19 : sheepGirl9,
//                                                     20 : drSheep0,
//                                                     21 : drSheep1,
//                                                     22 : drSheep2,
//                                                     23 : drSheep3,
//                                                     24 : drSheep4,
//                                                     25 : drSheep5,
//                                                     26 : drSheep6,
//                                                     27 : drSheep7,
//                                                     28 : drSheep8,
//                                                     29 : drSheep9,
//                                                     30 : dog0,
//                                                     31 : dog1,
//                                                     32 : dog2,
//                                                     33 : dog3,
//                                                     34 : dog4,
//                                                     35 : dog5,
//                                                     36 : dog6,
//                                                     37 : dog7,
//                                                     38 : dog8,
//                                                     39 : dog9,
//                                                     40 : wolf0,
//                                                     41 : wolf1,
//                                                     42 : wolf2,
//                                                     43 : wolf3,
//                                                     44 : wolf4,
//                                                     45 : wolf5,
//                                                     46 : wolf6,
//                                                     47 : wolf7,
//                                                     48 : wolf8,
//                                                     49 : wolf9,
//                                                     50 : sheepMan10,
//                                                     51 : sheepMan11,
//                                                     52 : sheepMan12,
//                                                     53 : sheepMan13,
//                                                     54 : sheepMan14,
//                                                     55 : sheepMan15,
//                                                     56 : sheepMan16,
//                                                     57 : sheepMan17,
//                                                     58 : sheepMan18,
//                                                     59 : sheepMan19,
//]

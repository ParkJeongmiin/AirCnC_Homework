//
//  Models.swift
//  AirCnC_Practice
//
//  Created by 박정민 on 2022/02/27.
//

import Foundation

// 튜플로 크기 정보 다루기
typealias Size = (w:Int, d:Int, h:Int)

// 구조체로 만들기
struct Item {
    var name: String
    var thumbnail: String // 썸네일 이미지
    var detailImage: [String]? // 상세 이미지는 없을 수도 있다.
    var price: Int
    var size: Size? // 크기 정보는 없을 수도 있다.
    var user: User
}

// 클래스로 만들기
class User {
    var name: String
    var image: String?
    // 생성자
    init(name: String, image: String?) {
        self.name = name
        self.image = image
    }
    
    // 미리 생성한 유저 정보
    static let ggamdi = User(name: "나희도", image:"ggamdi")
    static let franky = User(name: "김태리", image:"franky")
    static let goyangci = User(name: "남주혁", image:"goyangc")
    static let popo = User(name: "보나", image:"popo")
    static let jeongmin = User(name: "박정민", image:"jeongmin")
}


// 좋아요 탭
struct Liked {
    // Singleton
    static var shared = Liked()
    
    var saves : [Item] = []
    
    func isLiked(_ item: Item) -> Bool {
        for one in saves{
            // 제품이름이 같다고 비교한다. TODO : equal operator 작성
            if one.name == item.name {
                return true
            }
        }
        return false
    }
    
    mutating func add(_ item: Item) {
        self.saves.append(item)
    }
    
    mutating func remove(_ item: Item) {
        for (index, one) in saves.enumerated() {
            // 제품 이름으로 같다고 비교한다. TODO : equal operator 작성
            if one.name == item.name {
                saves.remove(at: index)
                return
            }
        }
    }
}

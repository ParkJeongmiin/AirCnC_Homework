//
//  ViewController.swift
//  AirCnC_Practice
//
//  Created by 박정민 on 2022/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var depthLabel: UILabel!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    var item: Item?
    
    // 이미지 갤러리
    var images: [String] = []
    var currentImageIndex = 0
    @IBAction func showPrevImage(_ sender: Any) {
        currentImageIndex -= 1
        self.showImage(index: currentImageIndex)
    }
    
    @IBAction func showNextImage(_ sender: Any) {
        currentImageIndex += 1
        self.showImage(index: currentImageIndex)
    }

    func showImage(index: Int) {
        let imageName = images[index]
        imageView.image = UIImage(named: imageName)
        
        // 이미지 이동이 불가능한 상태면 버튼을 disabled
        leftButton.isEnabled = index > 0
        rightButton.isEnabled = index < images.count - 1
    }
    
    // 좋아요 버튼
    @IBAction func handleLike(_ sender: Any) {
        //likeButton.isSelected = !likeButton.isSelected    at Step4
        if let item = self.item {
            //좋아요 목록에서 제거/추가
            if Liked.shared.isLiked(item) {
                Liked.shared.remove(item)
                likeButton.isSelected = false
            }
            else {
                Liked.shared.add(item)
                likeButton.isSelected = true
            }
        }
    }
    
    // 날짜
    let dateFormatter = DateFormatter()
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func handleDateChanged() {
        let dateStr = dateFormatter.string(from: datePicker.date)
        dateLabel.text = dateStr
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 처음 화면에서 사진은 첫번째 -> 왼쪽 버튼은 disabled 상태
        leftButton.isEnabled = false
        dateFormatter.dateStyle = .medium
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 받아온 데이터와 ViewController의 Outlet을 일치시키기
        // 옵셔널까지 해서
        if let item = item {
            titleLabel.text = item.name
            userNameLabel.text = item.user.name
            if let imageName = item.user.image {
                userImageView.image = UIImage(named: imageName)
            }
            priceLabel.text = String(item.price)
            
            if let size = item.size {
                depthLabel.text = "\(size.d)cm"
                widthLabel.text = "\(size.w)cm"
                heightLabel.text = "\(size.h)cm"
            }
            
            images = item.detailImage ?? []
            showImage(index: 0)
            
            self.title = item.name
            
            // 좋아요가 눌러졌는지 좋아요 버튼에 반영
            likeButton.isSelected = Liked.shared.isLiked(item)
        }
        
        handleDateChanged()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


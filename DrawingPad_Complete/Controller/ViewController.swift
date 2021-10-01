//
//  ViewController.swift
//  DrawingPad_Complete
//
//  Created by 김우성 on 2021/10/01.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {

    private var mainImageView: ImageZoomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        
    }

    private func setUpLayout() {
        let imageViewWidth =  view.bounds.width * 0.8
        let imageViewHeight =  view.bounds.width * 0.8
        let imageFrame = CGRect(x: 0, y: 0,
                                width: imageViewWidth,
                                height: imageViewHeight)
        mainImageView = ImageZoomView(frame: imageFrame)
        mainImageView.setImage(image: UIImage(named: "Developers") ?? UIImage())
        view.addSubview(mainImageView)
        setUpImageViews()
    }
    
    private func setUpImageViews() {
        mainImageView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.bottom.equalTo(view.snp.bottom)
            $0.left.equalTo(view.snp.left)
            $0.right.equalTo(view.snp.right)
        }
    }
}


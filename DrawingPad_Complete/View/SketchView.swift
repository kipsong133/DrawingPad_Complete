/*
 DrawingView.swift
 DrawingPad_Complete
 
 Created by 김우성 on 2021/10/01.
 
 
 [[그리기 기능 중 배경지 역할을 할 이미지를 담당할 UIScrollView의 SubClass]]
 - Zoom 기능을 구현했습니다.
 - 이미지 설정은 `setImage(image:)` 메소드를 통해서 VC에서 호출하여 할당합니다.
 */

import UIKit
import SnapKit
import Then

class SketchView: UIScrollView {

    // MARK: - Properties
    private var view = UIView()
    private var backgroundImageView = UIImageView()
    private var drawingImageView = UIImageView(image: UIImage())
    
    
    // MARK: - Lifecycle
    convenience init(backgroundImage: UIImage, frame: CGRect) {
        self.init(frame: frame)
        backgroundImageView.image = backgroundImage
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        setUpLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    private func setUpLayout() {
        self.addSubview(view)
        setUpView()
        view.addSubview(backgroundImageView)
        setUpBackgroundImageView()
        view.addSubview(drawingImageView)
        setUpDrawingImageView()
    }
    
    private func setUpView() {
        view.backgroundColor = .red
        view.snp.makeConstraints {
//            $0.top.equalTo(self.snp.top)
//            $0.bottom.equalTo(self.snp.bottom)
//            $0.left.equalTo(self.snp.left)
//            $0.right.equalTo(self.snp.right)
            $0.centerX.equalTo(self.snp.centerX)
            $0.centerY.equalTo(self.snp.centerY)
            $0.width.equalTo(self.snp.width)
            $0.height.equalTo(self.snp.height)
        }
    }
    
    private func setUpBackgroundImageView() {
        
        backgroundImageView.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
            $0.width.equalTo(view.snp.width)
            $0.height.equalTo(view.snp.height)
//            $0.top.equalTo(view.snp.top)
//            $0.bottom.equalTo(view.snp.bottom)
//            $0.left.equalTo(view.snp.left)
//            $0.right.equalTo(view.snp.right)
        }
    }
    
    private func setUpDrawingImageView() {
        
        drawingImageView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.bottom.equalTo(view.snp.bottom)
            $0.left.equalTo(view.snp.left)
            $0.right.equalTo(view.snp.right)
        }
    }
}


// MARK: - UIScrollViewDelegate
extension SketchView: UIScrollViewDelegate {
    
}

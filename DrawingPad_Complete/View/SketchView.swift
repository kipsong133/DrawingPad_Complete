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
//    private var view = UIView()
    private var backgroundImageView = UIImageView()
    private var drawingImageView = UIImageView(image: UIImage())
    private var viewModel: DrawingViewModel!
    public var canZoom: Bool = true
    
    // MARK: - Lifecycle
    convenience init(backgroundImage: UIImage, frame: CGRect) {
        self.init(frame: frame)
        self.set(image: backgroundImage)
        let viewModel
        = DrawingViewModel(lastPoint: .zero,
                           color: .black,
                           brushWidth: 10.0,
                           opacity: 1.0,
                           swiped: false)
        self.viewModel = viewModel
        //        backgroundImageView?.image = backgroundImage
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        backgroundImageView.isUserInteractionEnabled = true
        drawingImageView.isUserInteractionEnabled = true
        setUpLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    func set(image: UIImage) {
        backgroundImageView.removeFromSuperview()
        backgroundImageView.image = nil
        
        backgroundImageView = UIImageView(image: image)
        backgroundImageView.alpha = 0.5
        self.addSubview(backgroundImageView)
        configurateFor(imageSize: image.size)
        drawingImageView.backgroundColor = .red
        drawingImageView.alpha = 0.5
        self.addSubview(drawingImageView)
    }
    
    private func setUpLayout() {
//        self.addSubview(view)
//        setUpView()
        self.addSubview(backgroundImageView)
//        setUpBackgroundImageView()
        self.addSubview(drawingImageView)
//        setUpDrawingImageView()
        
        self.pinchGestureRecognizer?.isEnabled = false
        self.panGestureRecognizer.isEnabled = false
    }
    
    private func setUpView() {

    }
    
    private func setUpBackgroundImageView() {
        
        backgroundImageView.snp.makeConstraints {
//            $0.centerX.equalTo(self.snp.centerX)
//            $0.centerY.equalTo(self.snp.centerY)
//            $0.width.equalTo(self.snp.width)
//            $0.height.equalTo(self.snp.height)
            $0.top.equalTo(self.snp.top)
            $0.bottom.equalTo(self.snp.bottom)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
        }
        
        configurateFor(imageSize: backgroundImageView.frame.size)
    }
    
    private func setUpDrawingImageView() {
        drawingImageView.image = UIImage(named: "Moya") ?? UIImage()
        drawingImageView.alpha = 0.3
        drawingImageView.snp.makeConstraints {
//            $0.centerX.equalTo(backgroundImageView.snp.centerX)
//            $0.centerY.equalTo(backgroundImageView.snp.centerY)
//            $0.width.equalTo(backgroundImageView.snp.width)
//            $0.height.equalTo(backgroundImageView.snp.height)
            
            $0.top.equalTo(self.snp.top)
            $0.bottom.equalTo(self.snp.bottom)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
        }
    }
    
    func configurateFor(imageSize: CGSize) {
        self.contentSize = imageSize
        drawingImageView.frame = backgroundImageView.frame
        self.zoomScale = self.minimumZoomScale
        setCurrentMaxAndMinZoomScale()
    }
    
    func setCurrentMaxAndMinZoomScale() {
        let boundsSize = self.bounds.size
        let imageSize = backgroundImageView.bounds.size
        
        let xScale = boundsSize.width / imageSize.width
        let yScale = boundsSize.height / imageSize.height
        let minScale = min(xScale, yScale)
        
        var maxScale: CGFloat = 1.0
        if minScale < 0.1 {
            maxScale = 0.3
        }
        
        if minScale >= 0.1 && minScale < 0.5 {
            maxScale = 0.7
        }
        
        if minScale >= 0.5 {
            maxScale = max(1.0, minScale)
        }
        
        self.minimumZoomScale = minScale
        self.maximumZoomScale = 10
    }
}


// MARK: - UIScrollViewDelegate
extension SketchView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return canZoom ? scrollView.subviews.last : nil
    }

    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        print("Zoom 하기 직전...")
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        backgroundImageView.frame = drawingImageView.frame
    }
}

// MARK: - Drawing
extension SketchView {
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: drawingImageView)
        viewModel.touchBegan(location: location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        viewModel.touchesMoved(currentPoint: touch.location(in: drawingImageView))
        drawLine(from: viewModel.lastPoint, to: viewModel.currentPoint)
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if !(viewModel.swiped) {
            drawLine(from: viewModel.lastPoint,
                     to: viewModel.lastPoint)
        }
        
//        UIGraphicsBeginImageContext(drawingImageView.frame.size) // 이게 그림을 축소시키고 있음.
//        backgroundImageView.image?.draw(in: self.bounds, blendMode: .normal, alpha: 1.0)
        drawingImageView.image?.draw(in: drawingImageView.bounds, blendMode: .normal, alpha: viewModel.opacity) // 그리는 시점
        UIGraphicsEndImageContext()
        
        drawingImageView.image = UIGraphicsGetImageFromCurrentImageContext()

        //        tempImageView.image = nil
    }
    
    func drawLine(from fromPoint: CGPoint,
                  to toPoint: CGPoint) {
        
        UIGraphicsBeginImageContext(drawingImageView.bounds.size)
        print("drawingImageView.bounds.size: ", drawingImageView.bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        func connectingPoint(from: CGPoint, to: CGPoint) {
            context.move(to: from)
            context.addLine(to: to)
            context.setLineCap(.round)
        }
        
        drawingImageView.image?.draw(in: drawingImageView.bounds)
        
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        context.setLineCap(.round)
        
        if viewModel.ereaser {
            context.setBlendMode(.clear)
            
            context.setLineWidth(viewModel.brushWidth)
        } else {
            context.setBlendMode(.normal)
            context.setLineWidth(viewModel.brushWidth)
            context.setStrokeColor(viewModel.color.cgColor)
        }
        
        context.strokePath()
        drawingImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        drawingImageView.alpha = viewModel.opacity
        //        UIGraphicsEndImageContext()
        viewModel.changePoint()
    }
}

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

    // MARK: - Properties
    private var sketchView: SketchView!
    var undoMng = UndoManager()
    var viewModel: DrawingViewModel!
    
    private let blackPencil = UIButton().then {
        $0.backgroundColor = .black
        $0.tag = 1
        $0.addTarget(self, action: #selector(pencilButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewModel()
        setUpLayout()
        overrideUserInterfaceStyle = .light // light mode
    }

    // MARK: - Action
    @objc
    func pencilButtonDidTap(_ sender: UIButton) {
        print("검정펜 클릭...")
        viewModel.setColor(sender.tag)
        self.sketchView.canZoom.toggle()
    }
    
    // MARK: - Helper
    private func setUpViewModel() {
        self.viewModel
        = DrawingViewModel(lastPoint: .zero,
                           color: .black,
                           brushWidth: 10.0,
                           opacity: 1.0,
                           swiped: false)
    }
    
    private func setUpLayout() {
        let viewSize = CGRect(x: 0, y: 0, width: 350, height: 350)
        self.sketchView = SketchView(backgroundImage: UIImage(named: "Developers") ?? UIImage(), frame: viewSize)
        (sketchView).isUserInteractionEnabled = true
        view.addSubview(sketchView)
        setUpSketchView()
        view.addSubview(blackPencil)
        setUpBlackPencil()
    }
    
    private func setUpSketchView() {
        
        let image = UIImage(named: "Developers") ?? UIImage()
        let width = image.size.width
        let height = image.size.height
        
        sketchView.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
            $0.width.equalTo(width)
            $0.height.equalTo(height)
        }
    }
    
    private func setUpBlackPencil() {
        blackPencil.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(100)
            $0.centerX.equalTo(view.snp.centerX)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(40)
        }
    }
}


// MARK: - Drawing
extension ViewController {
    
}


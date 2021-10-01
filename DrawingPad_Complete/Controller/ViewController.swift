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

    private var sketchView: SketchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        overrideUserInterfaceStyle = .light // light mode
    }

    private func setUpLayout() {

        let viewSize = CGRect(x: 0, y: 0, width: 350, height: 350)
        self.sketchView = SketchView(backgroundImage: UIImage(named: "Developers") ?? UIImage(), frame: viewSize)
        (sketchView).isUserInteractionEnabled = true
        view.addSubview(sketchView)
        setUpSketchView()
    }
    
    private func setUpSketchView() {
        
        sketchView.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
            $0.width.equalTo(350)
            $0.height.equalTo(350)
        }
    }
}


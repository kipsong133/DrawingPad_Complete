//
//  DrawingView.swift
//  DrawingPad_Complete
//
//  Created by 김우성 on 2021/10/01.
//

import UIKit

class DrawingView: UIImageView {
    
}

extension DrawingView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self
    }
}



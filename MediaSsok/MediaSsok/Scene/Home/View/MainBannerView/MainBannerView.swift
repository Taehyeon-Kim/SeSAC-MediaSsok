//
//  MainBannerView.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/09.
//

import UIKit

final class MainBannerView: UIView {
    @IBOutlet weak var posterImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        let view = UINib(nibName: "MainBannerView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds
        addSubview(view)
        
        posterImageView.contentMode = .scaleAspectFill
    }
}

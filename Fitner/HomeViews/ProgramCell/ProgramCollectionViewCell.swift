//
//  ProgramCollectionViewCell.swift
//  FitStrap
//
//  Created by 1101249 on 12/24/22.
//

import UIKit
import SnapKit
import Kingfisher

class ProgramCollectionViewCell: UICollectionViewCell {
    
    private lazy var title: UILabel = {
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.backgroundColor  = .white
        $0.font = .boldSystemFont(ofSize: 23)
        return $0
    }(UILabel(frame: self.frame))
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0.4
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeSubviews() {
        self.contentView.addSubview(title)
        self.contentView.addSubview(imageView)
        title.snp.makeConstraints { make in
            make.top.right.bottom.equalTo(self.contentView).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        imageView.snp.makeConstraints { make in
            make.top.left.equalTo(self.contentView).inset(UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
            make.right.equalTo(self.title.snp.left).offset(-20)
            make.size.equalTo(CGSize(width: 80, height: 80))
            make.bottom.lessThanOrEqualTo(self.contentView).offset(-10);
        }
    }
    
    func configure(_ string: String) {
        title.text = string
        imageView.kf.setImage(with: URL(string: "http://d205bpvrqc9yn1.cloudfront.net/0009.gif"))
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        var targetSize = CGSize(width: layoutAttributes.frame.width, height: layoutAttributes.frame.height)
        
        if let screenSize = self.window?.windowScene?.screen.bounds.size {
            targetSize = CGSize(width: screenSize.width, height: targetSize.height)
        }
        
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
}

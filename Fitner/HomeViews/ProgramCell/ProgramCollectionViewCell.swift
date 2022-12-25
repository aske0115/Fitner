//
//  ProgramCollectionViewCell.swift
//  FitStrap
//
//  Created by 1101249 on 12/24/22.
//

import UIKit
import SnapKit

class ProgramCollectionViewCell: UICollectionViewCell {
    
    private lazy var title: UILabel = {
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.backgroundColor  = .white
        $0.font = .boldSystemFont(ofSize: 23)
        return $0
    }(UILabel(frame: self.frame))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeSubviews() {
        self.contentView.addSubview(title)
        title.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }
    
    func configure(_ string: String) {
        title.text = string
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: UIScreen.main.bounds.width, height: layoutAttributes.frame.height)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
}

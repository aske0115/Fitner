//
//  LayoutSection.swift
//  FitStrap
//
//  Created by 1101249 on 1/27/23.
//

import UIKit

protocol LayoutSection {
    var layoutSection: NSCollectionLayoutSection { get }
    func configureCell(collectionView: UICollectionView,
                       indexPath: IndexPath,
                       item: AnyHashable,
                       position: Int) -> UICollectionViewCell
    func header(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView?
}

extension LayoutSection {
    func header(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView? {
        nil
    }
}

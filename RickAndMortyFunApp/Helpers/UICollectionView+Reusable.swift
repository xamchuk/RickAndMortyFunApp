//
//  UICollectionView+Reusable.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 24/03/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

 extension UICollectionView {
     func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        register(cellType, forCellWithReuseIdentifier: className)
    }

     func register<T: UICollectionViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

     func register<T: UICollectionReusableView>(reusableViewType: T.Type,
                                                ofKind kind: String = UICollectionView.elementKindSectionHeader,
                                                bundle: Bundle? = nil) {
        let className = reusableViewType.className
        register(reusableViewType, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }

     func register<T: UICollectionReusableView>(reusableViewTypes: [T.Type],
                                                ofKind kind: String = UICollectionView.elementKindSectionHeader,
                                                bundle: Bundle? = nil) {
        reusableViewTypes.forEach { register(reusableViewType: $0, ofKind: kind, bundle: bundle) }
    }

     func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type,
                                                       for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as? T else {
            fatalError("Unable to dequeue cell with identifier: \(type.className)")
        }
        return cell
    }

     func dequeueReusableView<T: UICollectionReusableView>(with type: T.Type,
                                                           for indexPath: IndexPath,
                                                           ofKind kind: String = UICollectionView.elementKindSectionHeader) -> T {

        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.className, for: indexPath) as? T else {
            fatalError("\(type.className)")
        }
        return view
    }
}

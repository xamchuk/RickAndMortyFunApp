//
// Store
//
// Created by Alex Alexandrovych on 08/02/2019
// Copyright © 2019 Alexhome. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ type: T.Type) {
        let identifier = String(describing: T.self)
        register(T.self, forCellReuseIdentifier: identifier)
    }

    func register<T: UITableViewHeaderFooterView>(_ type: T.Type) {
        let identifier = String(describing: T.self)
        register(T.self, forHeaderFooterViewReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue cell with identifier: \(identifier)")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        let identifier = String(describing: T.self)
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
            fatalError("Unable to dequeue cell with identifier: \(identifier)")
        }
        return view
    }
}

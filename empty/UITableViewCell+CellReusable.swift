//
//  UITableViewCell+ReusableCell.swift
//  empty
//
//  Created by Dmitry.Tihonov on 6/14/18.
//  Copyright © 2018 Dmitry.Tihonov. All rights reserved.
//

import UIKit

extension UITableViewCell: CellReusable {
    static var identifier: String {
        return String(describing: self)
    }
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

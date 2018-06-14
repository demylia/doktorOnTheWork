//
//  ReusableCell.swift
//  empty
//
//  Created by Dmitry.Tihonov on 6/14/18.
//  Copyright © 2018 Dmitry.Tihonov. All rights reserved.
//

import UIKit

protocol CellReusable {
    static var identifier: String { get }
    static var nib: UINib { get }
}

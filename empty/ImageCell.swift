//
//  ImageCell.swift
//  empty
//
//  Created by demylia on 31.08.17.
//  Copyright © 2017 Dmitry.Tihonov. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    var photoImageView: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style,reuseIdentifier:reuseIdentifier)
        
        photoImageView = UIImageView(frame: contentView.bounds)
        contentView.addSubview(photoImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(url: URL?) {
        photoImageView.frame = contentView.frame
        
        guard let url = url else { return }
        
        photoImageView?.sd_setImage(with: url)
    }
}

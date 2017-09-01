//
//  FeedCell.swift
//  empty
//
//  Created by demylia on 29.08.17.
//  Copyright © 2017 Dmitry.Tihonov. All rights reserved.
//

import UIKit
import SDWebImage

class FeedCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var annotationLabel: UILabel!
    @IBOutlet weak var specialtyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func prepareForReuse() {
        
        titleLabel.text = nil
        annotationLabel.text = nil
        dateLabel.text = nil
        authorLabel.text = nil
        specialtyLabel.text = nil
        avatarImageView.image = nil
    }

    func reload(item: Textable){
        
        titleLabel.text = item.title
        annotationLabel.text = item.annotation
        dateLabel.text = item.createdAtDate
        authorLabel.text = item.author.shortName
        specialtyLabel.text = item.author.specialty
        avatarImageView.sd_setImage(with: item.author.avatarUrl)
    }
    
}


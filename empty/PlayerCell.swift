//
//  PlayerCell.swift
//  empty
//
//  Created by demylia on 31.08.17.
//  Copyright © 2017 Dmitry.Tihonov. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class PlayerCell: UITableViewCell {

    var playerView: YTPlayerView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style,reuseIdentifier:reuseIdentifier)
        
        playerView = YTPlayerView()
        contentView.addSubview(playerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload(videoId: String) {
        playerView.frame = contentView.frame
        let playerVars = ["playsinline": 1]
        playerView.load(withVideoId: videoId, playerVars: playerVars)
    }


}

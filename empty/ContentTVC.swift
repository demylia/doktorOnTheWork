//
//  ContentTVC.swift
//  empty
//
//  Created by demylia on 31.08.17.
//  Copyright © 2017 Dmitry.Tihonov. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import SDWebImage

extension ContentTVC {
    
    enum Section: Int {
        
        case feed = 0, photo, video
        
        var sectionName: String {
            switch self {
            case .feed: return "Заметка"
            case .photo: return "Фото"
            case .video: return "Видео"
            }
        }
    }
}

class ContentTVC: UITableViewController {

    var publication: Textable!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    deinit {
        Logger.log(type: .release, className: self.description)
    }
    
    private func setup(){
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(FeedCell.nib, forCellReuseIdentifier: FeedCell.identifier)
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.identifier)
        tableView.register(PlayerCell.self, forCellReuseIdentifier: PlayerCell.identifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        let numberOfSections = publication.countOfSection
        return numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case Section.feed.rawValue: return 1
        case Section.photo.rawValue: return publication.photos.count
        case Section.video.rawValue: return publication.videos.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case Section.feed.rawValue: return UITableViewAutomaticDimension
        case Section.photo.rawValue: return 200
        case Section.video.rawValue: return 250
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case Section.feed.rawValue: return Section.feed.sectionName
        case Section.photo.rawValue: return Section.photo.sectionName
        case Section.video.rawValue: return Section.video.sectionName
        default:
            return nil
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case Section.feed.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
            cell.reload(item: publication)
            return cell
        case Section.photo.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.identifier, for: indexPath)
            return cell
        case Section.video.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: PlayerCell.identifier, for: indexPath)
            return cell
        default:
            return tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        switch indexPath.section {

        case Section.photo.rawValue:
            let previewUrl = publication.photos[indexPath.row].previewUrl
            if let cell = cell as? ImageCell {
                cell.photoImageView.frame = cell.contentView.frame
                cell.photoImageView?.sd_setImage(with: previewUrl!)
            }
        case Section.video.rawValue:
            if let cell = cell as? PlayerCell {
                cell.playerView.frame = cell.contentView.frame
                let playerVars = ["playsinline": 1]
                let videoId = publication.videos[indexPath.row].videoId
                cell.playerView.load(withVideoId: videoId, playerVars: playerVars)
            }
        default:
            break
        }
    }
}

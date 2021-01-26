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

class ContentTVC: UITableViewController {

    var publication: Textable!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setupVC(publication: Textable) {
        self.publication = publication
    }

    deinit {
        Logger.log(type: .release, className: self.description)
    }
    
    private func setup(){
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(FeedCell.nib, forCellReuseIdentifier: FeedCell.identifier)
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.identifier)
        tableView.register(PlayerCell.self, forCellReuseIdentifier: PlayerCell.identifier)
    }
}

extension ContentTVC {

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
        
        guard let section = Section(rawValue: indexPath.section) else { return 0 }
        
        return section.height
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let section = Section(rawValue: section) else { return nil }
        
        return section.sectionName
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: section.cellIdentifier, for: indexPath)
        if let cell = cell as? FeedCell {
            cell.reload(item: publication)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case Section.photo.rawValue:
            if let cell = cell as? ImageCell {
                let previewUrl = publication.photos[indexPath.row].previewUrl
                cell.reload(url: previewUrl)
            }
        case Section.video.rawValue:
            if let cell = cell as? PlayerCell {
                cell.reload(videoId: publication.videos[indexPath.row].videoId)
            }
        default:
            break
        }
    }
}

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
        var height: CGFloat {
            switch self {
            case .feed: return UITableView.automaticDimension
            case .photo: return 200
            case.video: return 250
            }
        }
        var cellIdentifier: String {
            switch self {
            case .feed: return FeedCell.identifier
            case .photo: return ImageCell.identifier
            case .video: return PlayerCell.identifier
            }
        }
    }
}

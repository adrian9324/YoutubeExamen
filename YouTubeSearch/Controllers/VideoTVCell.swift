//
//  VideoTVCell.swift
//  YouTubeSearch
//
//  Created by Adrián Salazar G on 09/07/18.
//  Copyright © 2018 Adrián Salazar G. All rights reserved.
//

import UIKit

class VideoTVCell: UITableViewCell {

    //MARK: IBOUTLETS
    
    @IBOutlet weak var ivVideo: UIImageView!
    @IBOutlet weak var lblVideo: UILabel!
    
    var videoModel:VideoModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /// Set up cell
    ///
    /// - Parameter videModel: VideoModel
    func setUpCell(videModel:VideoModel){
        self.lblVideo.text = "\(videModel.title)\n\(videModel.publishDate.datteFormaterDDMMMYYY!)"
        self.ivVideo.downloadedFrom(url: URL(string: videModel.imageUrl)!)
    }
}

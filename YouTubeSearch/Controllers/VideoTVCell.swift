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
        var arrTextAttribute:[TextAttribute] = []
        arrTextAttribute.append(TextAttribute(text: "\(videModel.title)", textFont: UIFont.systemFont(ofSize: 15), textColor: UIColor.black))
        arrTextAttribute.append(TextAttribute(text: "\n\(videModel.publishDate.datteFormaterDDMMMYYY!)", textFont: UIFont.systemFont(ofSize: 12), textColor: UIColor.gray))
        self.lblVideo.attributedText = CoreText().attributeTextWith(arrTextAttrbutes: arrTextAttribute)
        self.ivVideo.downloadedFrom(url: URL(string: videModel.imageUrl)!)
    }
}

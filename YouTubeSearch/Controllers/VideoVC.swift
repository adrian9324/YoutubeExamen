//
//  VideoVC.swift
//  YouTubeSearch
//
//  Created by Adrián Salazar G on 08/07/18.
//  Copyright © 2018 Adrián Salazar G. All rights reserved.
//

import UIKit

class VideoVC: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var vYTPlayer: YTPlayerView!

    //MARK: VARIABLE
    var idVideoSelected:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vYTPlayer.delegate = self
        self.vYTPlayer.load(withVideoId: idVideoSelected)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    

}

extension VideoVC: YTPlayerViewDelegate{
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .playing:
            print("Reproduciendo")
            break
        case .paused:
            print("Pausado")
            break
        default:
            break
        }
    }
    
}

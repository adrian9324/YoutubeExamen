//
//  HomeVC.swift
//  YouTubeSearch
//
//  Created by Adrián Salazar G on 08/07/18.
//  Copyright © 2018 Adrián Salazar G. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: IBOUTLETS
    @IBOutlet weak var tvContentVideo: UITableView!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var btnCancelSearch: UIButton!
    
    //MARK: VARIABLE
    var activityView:UIActivityIndicatorView!
    var arrVideos:[VideoModel]!
    var idVideoSelected:String!
    var vBloor:UIView!
    var lblEmpty:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "YouTube"        
        self.btnCancelSearch.isHidden = true
        self.tvContentVideo.separatorStyle = .none
        self.arrVideos = []
        self.addLabelEmpty()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! VideoVC
        destinationVC.idVideoSelected = self.idVideoSelected
    }
    
    //MARK: FUNCTIONS
    
    /// Add label empty
    func addLabelEmpty(){
        guard self.lblEmpty == nil else {
            return
        }
        self.lblEmpty = UILabel(frame: CGRect(x: UIScreen.main.bounds.width/2-80, y: UIScreen.main.bounds.height/2-20, width: 160, height: 40))
        self.lblEmpty.text = "No hay resultados"
        self.lblEmpty.textColor = UIColor.black
        self.lblEmpty.textAlignment = .center
        self.view.addSubview(self.lblEmpty)
    }
    
    /// Search text
    func searchText(){
        self.arrVideos = []
        self.tvContentVideo.reloadData()
        self.initActivity()
        VideoModel.getVideosWith(textToSearch: self.tfSearch.text!) { (error, response) in
            guard let e = error else{
                self.arrVideos = VideoModel.getVideosModelWith(arrDic: response!)
                self.tvContentVideo.reloadData()
                self.arrVideos.isEmpty ? self.addLabelEmpty() : (self.lblEmpty != nil ? self.lblEmpty.removeFromSuperview() : nil)
                self.removeActivity()
                return
            }
            self.removeActivity()
            self.showBasicAlert(title: "¡Ups!", message: e.localizedDescription, textButton: "Aceptar")
        }
    }
    
    /// Init activity
    func initActivity(){
        self.vBloor = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.vBloor.backgroundColor = UIColor.groupTableViewBackground
        self.vBloor.alpha = 0.8
        self.activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        self.activityView.center = self.view.center
        self.activityView.color = UIColor.black
        self.activityView.startAnimating()
        self.vBloor.addSubview(self.activityView)
        self.view.addSubview(self.vBloor)
        self.tvContentVideo.isHidden = true
        self.tfSearch.isEnabled = false
    }
    
    /// Remove activity
    func removeActivity(){
        self.vBloor.removeFromSuperview()
        self.activityView.removeFromSuperview()
        self.tvContentVideo.isHidden = false
        self.tfSearch.isEnabled = true
    }
    
    //MARK: IBACTIONS
    
    /// Show alert with textfield
    ///
    /// - Parameter sender: Any
    @IBAction func showAlertWithTextField(_ sender: Any) {
        self.tfSearch.becomeFirstResponder()
    }
    
    /// Touch cancel search
    ///
    /// - Parameter sender: Any
    @IBAction func touchCancelSearch(_ sender: Any) {
        self.btnCancelSearch.isHidden = true
        self.dismissKeyBoard()
    }
    
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellVideos", for: indexPath) as! VideoTVCell
        cell.setUpCell(videModel: self.arrVideos[indexPath.row])
        return cell
    }
    
}

// MARK: - UITextFieldDelegate
extension HomeVC:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.btnCancelSearch.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.tfSearch.resignFirstResponder()
        self.btnCancelSearch.isHidden = true
        self.searchText()
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.idVideoSelected = self.arrVideos[indexPath.row].idVideo
        self.performSegue(withIdentifier: "home_video", sender: self)
    }
    
}

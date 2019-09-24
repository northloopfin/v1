//
//  CampusCashbackController.swift
//  NorthLoopFin
//
//  Created by Milan Mendpara on 23/09/19.
//  Copyright © 2019 NorthLoop. All rights reserved.
//

import UIKit

class CampusCashbackController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!

    var campusPresenter: CampusPresenter!
    var campusVotePresenter: CampusVotePresenter!
    var campusArr:[Campus] = []
    var selectedCampus:[String] = []
    
    @IBOutlet weak var btnDone: RippleButton!
    @IBOutlet weak var constSaveHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRightNavigationBar()
        self.configureTable()
//        self.getCampusList()
        // Do any additional setup after loading the view.
    }
    
    func getCampusList() {
        self.campusPresenter = CampusPresenter.init(delegate: self)
        self.campusPresenter.sendCampusRequest(name: "")
//        self.btnRedeem.isEnabled = false
    }
    @IBAction func btnDone_pressed(_ sender: UIButton) {
        var arrPlaceIds:[String] = []
        for obj in campusArr {
            arrPlaceIds.append(obj.id)
        }
        self.campusVotePresenter = CampusVotePresenter.init(delegate: self)
        self.campusVotePresenter.sendCampusVoteRequest(placeList: arrPlaceIds, voteList: selectedCampus)
    }
}

extension CampusCashbackController: UITableViewDelegate,UITableViewDataSource {
    func configureTable(){
        self.tableView.register(UINib(nibName:"CampusCashbackCell", bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: "CampusCashbackCell")
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return campusArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CampusCashbackCell", for: indexPath) as! CampusCashbackCell
        cell.bindData(data: campusArr[indexPath.row], selected: selectedCampus.contains(campusArr[indexPath.row].id))
        cell.lblCount.text = String(indexPath.row+1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let campus = campusArr[indexPath.row]
        if !selectedCampus.contains(campus.id) {
            selectedCampus.append(campus.id)
        }else if selectedCampus.contains(campus.id) {
            selectedCampus.remove(at: selectedCampus.index(of:campus.id)!)
        }
        self.btnDone.isEnabled = selectedCampus.count > 0
        self.tableView.reloadData()
    }
}

extension CampusCashbackController: CampusDelegate{
    func didFetchCampus(data: CampusData) {
        if data.values.count > 0 {
            campusArr = data.values
        }
    }
    
    func didFetchUniversities(data: [String]) {
        
    }
    
    func emptyCampus() {
    }
}

extension CampusCashbackController: CampusVoteDelegate{
    func didCampusVote(data: CampusVote) {
        self.toast(message: "Thanks for voting!")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.navigationController?.popViewController(animated: true)
        })
//        self.showAlert(title: "", message: data.message)
    }
}

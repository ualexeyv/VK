//
//  MyGroupViewController.swift
//  VK
//
//  Created by пользовтель on 10.03.2021.
//

import UIKit

class MyGroupViewController: UIViewController {
    let VKServ = VKService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            [weak self] in self?.VKServ.loadData(getData: "groups.get")
        }
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var myGroupTableView: UITableView! {
        didSet {
            myGroupTableView.delegate = self
            myGroupTableView.dataSource = self
        }
    }

}
extension MyGroupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mygroup.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myGroupTableView.dequeueReusableCell(withIdentifier: "reusableCell") as! UserTableViewCell
        cell.avatarImage.image = mygroup[indexPath.row].groupAvatar
        cell.nameLabl.text = mygroup[indexPath.row].groupName
        return cell
    }
    
    @IBAction func addGroup (segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup",
        let sourceVC = segue.source as? GlobalGroupViewController,
        let selectedGroup = sourceVC.selectedGroup,
        let selectedGroupName = sourceVC.selectedGroup?.groupName{
            if !mygroup.contains(where: { $0.groupName == selectedGroupName }) {
            
                mygroup.append(selectedGroup)
            myGroupTableView.reloadData()
            }
        }
    }
    
}

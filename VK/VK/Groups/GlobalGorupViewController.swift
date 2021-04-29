//
//  GlobalGorupViewController.swift
//  VK
//
//  Created by пользовтель on 10.03.2021.
//

import UIKit

class GlobalGroupViewController: UIViewController {
    let VKServ = VKService()
    var selectedGroup: VKGroup?
    var selectedGroupName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            [weak self] in self?.VKServ.searchGroups(searchField: "swift")
//        }
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var globalGroupTableView: UITableView! {
        didSet {
            globalGroupTableView.delegate = self
            globalGroupTableView.dataSource = self
        }
    }

}
extension GlobalGroupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalGroup.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = globalGroupTableView.dequeueReusableCell(withIdentifier: "reusableCell") as! UserTableViewCell
        cell.avatarImage.image = globalGroup[indexPath.row].groupAvatar
        cell.nameLabl.text = globalGroup[indexPath.row].groupName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedGroup = globalGroup[indexPath.row]
        selectedGroupName = globalGroup[indexPath.row].groupName
        performSegue(withIdentifier: "addGroup", sender: nil)
    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



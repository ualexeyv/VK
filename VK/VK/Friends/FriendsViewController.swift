//
//  FriendsViewController.swift
//  VK
//
//  Created by пользовтель on 02.03.2021.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    let VKServ = VKService()
    
    var keys: [String] = []
    var friendSorted: [String:[VKUser]] = [:]
    var friendsFiltered: [VKUser] = []
    
    let searchController = UISearchController (searchResultsController: nil)
    var arrayOfUsers: [VKUser] = []
    var isSearchBarEmpty: Bool {return searchController.searchBar.text?.isEmpty ?? true}
    var isFilltering: Bool { return searchController.isActive && !isSearchBarEmpty}
    
    
    
    func checkSearchFilter() {
        keys = []
        arrayOfUsers = []
        friendSorted = [:]
        if isFilltering {
            arrayOfUsers = friendsFiltered
        } else {
            arrayOfUsers = users
        }
        for user in arrayOfUsers {
            let firstLetter = String(user.fio.first!)
            if friendSorted[firstLetter] != nil {
                friendSorted[firstLetter]?.append(user)
            } else {
                friendSorted[firstLetter] = [user]
            }
        }
        keys = Array (friendSorted.keys).sorted(by: <)
    
    }
    
    //MARK : - Массив друзей, которые пытаемся получить от сервера
    var friend: [Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //пытаюсь получить ответ от сервера ВК со данными друга
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            [weak self] in self?.VKServ.loadFriendData(extraPath: "friends.get") { [weak self] friend in
                self?.friend = friend
            }
        }
        //пытаюсь получить пользователя по конкретному id
        
        
        checkSearchFilter()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        checkSearchFilter()
        return friendSorted.count
    }
    @IBOutlet weak var friendsTableView: UITableView! {
        didSet {
            friendsTableView.delegate = self
            friendsTableView.dataSource = self
        }
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        checkSearchFilter()
        return keys
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        checkSearchFilter()
        return keys[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        checkSearchFilter()
        view.tintColor = UIColor.gray
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.text = keys[section]
        header.alpha = 0.5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        checkSearchFilter()
        let key = keys[section]
        return friendSorted[key]!.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        checkSearchFilter()
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell") as! UserTableViewCell
        cell.backgroundColor = UIColor.clear
    
        let key = keys[indexPath.section]
        let user = friendSorted[key]![indexPath.row]
        let fio = user.fio
        let avatar = user.friendAvatar
        cell.nameLabl.text = fio
        cell.avatarImage.image = avatar
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkSearchFilter()
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(identifier: "PhotoVC") as! PhotoViewController
        let key = keys[indexPath.section]
        let user = friendSorted[key]![indexPath.row]
        
        VC.photoArray = user.userPhoto
        show(VC, sender: nil)
    }
    func filteredContentForSearchText (_ searchText: String) {
        friendsFiltered = users.filter { (friend: VKUser) -> Bool in
            return friend.fio.lowercased().contains(searchText.lowercased())
        }
       
        friendsTableView.reloadData()
    }
}
extension UITableView {
    @IBInspectable var backgroundImage: UIImage? {
        get {
            return nil
        }
        set {
            backgroundView = UIImageView(image: newValue)
        }
    }
}
extension FriendsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filteredContentForSearchText(searchBar.text!)
    }
}

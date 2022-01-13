//
//  ViewController.swift
//  Humming Homes Test
//
//  Created by Cezhar Arévalo on 13-01-22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var tableView:UITableView!
    var people = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName:"PeopleCell", bundle: nil), forCellReuseIdentifier:"PeopleCell")
        
        tableView.delegate = self
        tableView.dataSource = self
       
        API.getPeople(){ people in
            self.people.removeAll()
            guard let p = people else{
                return
            }
            self.people.append(contentsOf: p)
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
        
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath) as? PeopleCell else{
            return UITableViewCell()
        }
        let pos = indexPath.row
        cell.nameLabel.text = people[pos]
        return cell
        
    }
    
    
}


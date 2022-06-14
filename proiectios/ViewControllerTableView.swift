//
//  ViewControllerTableView.swift
//  proiectios
//
//  Created by user216341 on 6/15/22.
//

import UIKit

class ViewControllerTableView: UIViewController {
    @IBOutlet var tableView: UITableView!
    let names = [
    "Benedict Cumberbatch",
    "Elisabeth Olsen",
    "Patrick Stewart",
    "Charlize Theron"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }


}

extension ViewControllerTableView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("salutare :)")
    }
}

extension ViewControllerTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
}


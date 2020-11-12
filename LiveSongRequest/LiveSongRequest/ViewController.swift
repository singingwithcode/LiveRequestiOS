//
//  ViewController.swift
//  LiveSongRequest
//
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.rowHeight = 60;
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! TableViewCellEvent
        cell.eventNameTitle.text = eventList[indexPath.row].eventName
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = UIImage(named: "logo2")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableview.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        //nothing
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let ViewControllerEventCode = segue.destination as? ViewControllerEventCode {
            if let indexPath = tableview.indexPathForSelectedRow {
                ViewControllerEventCode.event = eventList[indexPath.row]
            }
        }
    }
}


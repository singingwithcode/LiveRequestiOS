//
//  ViewControllerEventAdmin.swift
//  LiveSongRequest
//
//

import UIKit

class ViewControllerEventAdmin: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //@IBOutlet weak var tableview: UITableView!
    
    var event: Event?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.rowHeight = 60;
        return event!.songs.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "adminCell", for: indexPath) as! TableViewCellAdmin
        if let songName = event?.songs[indexPath.row].songName {
            if let artistName = event?.songs[indexPath.row].artistName {
                cell.songName.text = songName + " - " + artistName
            }
        }
        return cell
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            event?.songs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }

    
    @IBAction func endEvent(_ sender: UIButton) {
        let actionSheetController : UIAlertController = UIAlertController(title: "Are you sure?", message: "This would remove all songs and the entire event.", preferredStyle: .actionSheet)
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .default)
        let forceActionButton = UIAlertAction(title: "Continue", style: .destructive) { action in
            //remove event
            if let found = eventList.index(where: { $0.eventName == self.event?.eventName }) {
                eventList.remove(at: found)
                self.performSegue(withIdentifier: "unwindToViewController", sender: self)
            }
            //prompt
            let message = "The event has been successfully removed."
            let alertController = UIAlertController(title: "Bam!", message: message, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
        }
        actionSheetController.addAction(forceActionButton)
        actionSheetController.addAction(cancelActionButton)
        present(actionSheetController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //add logo
        let logo = UIImage(named: "logo2")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        //adds a fake button to center logo better
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "    ", style: .plain, target: self, action: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.tableview.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

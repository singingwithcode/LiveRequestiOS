//
//  ViewControllerSongList.swift
//  LiveSongRequest
//
//

import UIKit

class ViewControllerSongList: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var event : Event?
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.rowHeight = 60;
        return event!.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! TableViewCellSong
        if let songName = event?.songs[indexPath.row].songName {
            if let artistName = event?.songs[indexPath.row].artistName {
                cell.songName.text = songName
                cell.artistName.text = artistName
                let voteCount = event?.songs[indexPath.row].votes.countVotes()
                cell.voteCount.text = String(describing: voteCount!)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let closeAction = UIContextualAction(style: .normal, title:  "Upvote", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            //Downvote here
            //HARDCODED user #1 for future implementation
            self.event?.songs[indexPath.row].votes.addVote(userID: 1, vote: Vote.UP)
            self.tableView.reloadData()
            success(true)
        })
        closeAction.backgroundColor = .green
        
        return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let modifyAction = UIContextualAction(style: .normal, title:  "Downvote", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            //upvote here
            //HARDCODED user #1 for future implementation
            self.event?.songs[indexPath.row].votes.addVote(userID: 1, vote: Vote.DOWN)
            self.tableView.reloadData()
            success(true)
        })
        modifyAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [modifyAction])
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
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toAdminCode(_ sender: UIButton) {
        performSegue(withIdentifier: "toAdminCode", sender: self)
    }
    
    @IBAction func toAddSong(_ sender: UIButton) {
        performSegue(withIdentifier: "toAddSong", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toAdminCode" {
            if let viewControllerAdminCode = segue.destination as? ViewControllerAdminCode {
                viewControllerAdminCode.event = event
            }
        } else if segue.identifier == "toAddSong" {
            if let viewControllerSongAdd = segue.destination as? ViewControllerSongAdd {
                viewControllerSongAdd.event = event
            }
        }
    }
}

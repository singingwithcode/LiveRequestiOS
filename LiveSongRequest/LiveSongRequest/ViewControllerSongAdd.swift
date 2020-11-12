//
//  ViewControllerSongAdd.swift
//  LiveSongRequest
//
//

import UIKit

class ViewControllerSongAdd: UIViewController {
    
    @IBOutlet weak var userTextS: UITextField!
    @IBOutlet weak var userTextA: UITextField!
    
    var event : Event?

    override func viewDidLoad() {
        super.viewDidLoad()
        //add logo
        let logo = UIImage(named: "logo2")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        //adds a fake button to center logo better
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "    ", style: .plain, target: self, action: nil)
        
        //double tab for submission
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapRecognizer)
    }
    
    @objc
    func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        addSong(sender)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backgroundTouched(_ sender: Any) {
        dismissKeys()
    }
    
    @IBAction func textFieldDidBeginEditing(_ sender: UITextField) {
        moveTextField(textField: sender, moveDistance: -150, up: true)
    }
    
    @IBAction func textFieldDidEndEditing(_ sender: UITextField) {
        moveTextField(textField: sender, moveDistance: -150, up: false)
    }
    
    func moveTextField(textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: CGFloat(0), dy: CGFloat(movement))
        UIView.commitAnimations()
    }

    @IBAction func addSong(_ sender: Any) {
        dismissKeys()
        
        if userTextS.text?.count == 0 || userTextA.text?.count == 0 {
            let message = "Try to put something in all the boxes."
            let alertController = UIAlertController(title: "You Forgot Something", message: message, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            event?.songs.append(Song(userTextS.text!, userTextA.text!))
        }
        
        self.navigationController?.popViewController(animated: true) //dismiss
    }
    
    func dismissKeys() {
        userTextA.resignFirstResponder()
        userTextS.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

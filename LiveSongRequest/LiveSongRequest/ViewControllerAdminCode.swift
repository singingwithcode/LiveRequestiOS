//
//  ViewControllerAdminCode.swift
//  LiveSongRequest
//
//

import UIKit

class ViewControllerAdminCode: UIViewController {
    
    var event: Event?
    
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var eventNameL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add logo
        let logo = UIImage(named: "logo2")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        //adds a fake button to center logo better
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "    ", style: .plain, target: self, action: nil)
        
        eventNameL.text = event?.eventName
        
        //double tab for submission
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapRecognizer)
    }
    
    @objc
    func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        submitCode(sender)
    }
    
    @IBAction func backgroundTouched(_ sender: Any) {
        userText.resignFirstResponder()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitCode(_ sender: Any) {
        userText.resignFirstResponder()
        let len = userText.text!.count
        if len == 0 {
            let message = "You didn't enter anything!"
            let alertController = UIAlertController(title: "No Password", message: message, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
        } else if (event?.adminCode == userText.text!) {
            //right password
            performSegue(withIdentifier: "toEventAdminList2", sender: self)
        } else {
            //wrong password
            let message = "Try again or you are not the admin of this event."
            let alertController = UIAlertController(title: "Wrong Password", message: message, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toEventAdminList2" {
            if let viewControllerEventAdmin = segue.destination as? ViewControllerEventAdmin {
                viewControllerEventAdmin.event = event
            }
        }
    }

}

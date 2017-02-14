//
//  ComposeViewController.swift
//  TwitterDemo
//
//  Created by Rob Hernandez on 2/13/17.
//  Copyright © 2017 Robert Hernandez. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var charCount: UIBarButtonItem!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var textSection: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textSection.delegate = self


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweet(_ sender: Any) {
    }

    
    func textViewDidChange(_ textView: UITextView) {
        if  0 < (141 - textSection.text!.characters.count) {
            charCount.tintColor = UIColor.lightGray
            charCount.title = "\(140 - textSection.text!.characters.count)"
        }
        else{
            charCount.tintColor = UIColor.red
            charCount.title = "\(140 - textSection.text!.characters.count)"
        }
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

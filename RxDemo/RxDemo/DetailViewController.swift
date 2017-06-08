//
//  DetailViewController.swift
//  RxDemo
//
//  Created by redtwowolf on 08/06/2017.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    convenience init(viewModel: DetailViewModel) {
        self.init(nibName: "DetailViewController", bundle: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

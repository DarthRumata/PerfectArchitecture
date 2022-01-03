//
//  ViewController.swift
//  TestDI
//
//  Created by Stanislav Kirichok on 01.12.2021.
//

import UIKit
import NeedleFoundation
import CommonLogic
import XCoordinator

class FirstViewController: UIViewController {
    var viewModel: FirstViewModel!

    @IBAction func handleButtonTap(_ sender: Any) {
        viewModel.moveToSecond()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

class FirstViewModel {
    private let router: WeakRouter<FirstFlowRoute>
    
    init(router: WeakRouter<FirstFlowRoute>) {
        self.router = router
        print("ViewModel created")
    }
    
    deinit {
        print("ViewModel deinit")
    }
    
    func moveToSecond() {
        router.trigger(.navigateToSecond)
    }
}


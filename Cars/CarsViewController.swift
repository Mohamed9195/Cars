//
//  CarsViewController.swift
//  Cars
//
//  Created by Mohamed Hashem on 25/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

class CarsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var carMakesTableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private let viewModel = CarsMakesViewModel()
    
    // MARK: - Init
    init() {
        super.init(nibName: "\(CarsViewController.self)", bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - DeInit
    deinit {
        debugPrint("\(CarsViewController.self)" + "Release from Memory")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "cars Makes"
        self.viewModel.requestCarsMakesData()
        carMakesTableBinding()
    }
    
    private func carMakesTableBinding() {
        
        carMakesTableView.register(UINib(nibName: "CarMakeCell", bundle: nil), forCellReuseIdentifier: String(describing: CarMakeCell.self))
        
        viewModel.cars.bind(to: carMakesTableView.rx.items(cellIdentifier: "CarMakeCell",
                                                           cellType: CarMakeCell.self)) { row, car, cell in
            cell.config(name: car.name ?? "--")
        }.disposed(by: disposeBag)
        
        carMakesTableView.rx.willDisplayCell
            .subscribe(onNext: ({ cell, indexPath in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
                if (self.viewModel.countCell - 1) == indexPath.row {
                    self.viewModel.requestNextCarsMakesData()
                }
            })).disposed(by: disposeBag)
        
        
        carMakesTableView.rx.modelSelected(carMakesModel.self).subscribe { [weak self]  car in
            guard let self = self else { return }
            let carModelViewController = CarsModelViewController()
            carModelViewController.model = car.element?.niceName ?? ""
            
            self.navigationController?.pushViewController(carModelViewController, animated: true)
        }.disposed(by: disposeBag)
    }
}

//
//  CarsModelViewController.swift
//  Cars
//
//  Created by Mohamed Hashem on 05/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class CarsModelViewController: UIViewController {
    
    @IBOutlet weak var carModelTableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private let viewModel = CarModelViewModel()
    var model = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "cars Model"
        self.viewModel.requestCarsModelData(model: model)
        carMakesTableBinding()
    }
    
    private func carMakesTableBinding() {
        
        carModelTableView.register(UINib(nibName: "CarModelCell", bundle: nil), forCellReuseIdentifier: String(describing: CarModelCell.self))
        
        viewModel.cars.bind(to: carModelTableView.rx.items(cellIdentifier: "CarModelCell",
                                                           cellType: CarModelCell.self)) { row, car, cell in
            cell.carModelName.text = car.modelName
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        carModelTableView.rx.willDisplayCell
            .subscribe(onNext: ({ cell, indexPath in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
//                if (self.viewModel.countCell - 1) == indexPath.row {
//                    self.viewModel.requestNextCarsModelsData(model: self.model)
//                }
            })).disposed(by: disposeBag)
        
        carModelTableView.rx.modelSelected(CarModelInfo.self).subscribe { [weak self]  car in
            guard let self = self else { return }
            let carDetailsViewController = CarsDetailsViewController()
            carDetailsViewController.model = car.element?.modelName ?? ""
            carDetailsViewController.make = car.element?.makeName ?? ""
            carDetailsViewController.makeName = car.element?.makeNiceName ?? ""
            carDetailsViewController.modelName = car.element?.modelNiceName ?? ""
            
            self.navigationController?.pushViewController(carDetailsViewController, animated: true)
        }.disposed(by: disposeBag)
    }
}

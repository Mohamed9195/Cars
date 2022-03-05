//
//  CarsMakesViewModel.swift
//  Cars
//
//  Created by Mohamed Hashem on 23/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

class CarsMakesViewModel {
    
    let cars : PublishSubject<[carMakesModel]> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    let error : PublishSubject<Error> = PublishSubject()
    private var currentPage = 1
    private let disposable = DisposeBag()
    private var response: [carMakesModel] = []
    var countCell = 0
    
    func requestCarsMakesData() {
        self.loading.onNext(true)
        
        CarsEndPoints.shared
            .provider.rx
            .request(.getCarMakes(pageNo: 1, pageSize: 10))
            .filterSuccessfulStatusCodes()
            .timeout(.seconds(120), scheduler: MainScheduler.instance)
            .retry(2)
            .map(CarMakes.self)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                if let cars = response.results {
                    self?.response = cars
                    self?.countCell = cars.count
                    self?.cars.onNext(cars)
                }
                
            }) { [weak self] error in
                self?.error.onNext(error)
            }.disposed(by: disposable)
    }
    
    func requestNextCarsMakesData() {
        currentPage += 1
        guard currentPage < 10 else { return }
        self.loading.onNext(true)
        
        CarsEndPoints.shared
            .provider.rx
            .request(.getCarMakes(pageNo: currentPage, pageSize: 10))
            .filterSuccessfulStatusCodes()
            .timeout(.seconds(120), scheduler: MainScheduler.instance)
            .retry(2)
            .map(CarMakes.self)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                if let cars = response.results {
                    if var lastResponse = self?.response {
                        lastResponse += cars
                        self?.response = lastResponse
                    }
                    self?.cars.onNext(self?.response ?? [])
                    self?.countCell = self?.response.count ?? 0
                }
                
            }) { [weak self] error in
                self?.error.onNext(error)
            }.disposed(by: disposable)
    }
}

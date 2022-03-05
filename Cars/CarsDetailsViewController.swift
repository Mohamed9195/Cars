//
//  CarsDetailsViewController.swift
//  Cars
//
//  Created by Mohamed Hashem on 05/03/2022.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage
import ImageSlideshow

class CarsDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageSlider: ImageSlideshow!
    @IBOutlet weak var detailsTextField: UITextView!
    
    private let disposeBag = DisposeBag()
    
    private let viewModel = CarDetailsViewModel()
    var makeName = ""
    var modelName = ""
    var make = ""
    var model = ""
    
    // MARK: - Init
    init() {
        super.init(nibName: "\(CarsDetailsViewController.self)", bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - DeInit
    deinit {
        debugPrint("\(CarsDetailsViewController.self)" + "Release from Memory")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "cars Details"
        viewModel.requestCarsDetailsData(makeName: makeName,
                                         modelName: modelName,
                                         make: make,
                                         model: model)
        carsDetailsBinding()
    }
    
    func carsDetailsBinding() {
        viewModel.carsImage.asObserver().subscribe { [weak self] images in
            guard let self = self else { return }
            var kingfisherSource: [SDWebImageSource] = []
            images.element?.forEach { result in
                if let imageSource = SDWebImageSource(urlString: result) {
                    kingfisherSource.append(imageSource)
                }
            }
            
            self.imageSlider.slideshowInterval = 10.0
            self.imageSlider.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
            self.imageSlider.contentScaleMode = UIViewContentMode.scaleToFill
            
            self.imageSlider.activityIndicator = DefaultActivityIndicator()
            self.imageSlider.setImageInputs(kingfisherSource)
        }.disposed(by: disposeBag)
        
        viewModel.cars.asObserver().subscribe { [weak self] cars in
            guard let self = self else { return }
            
            self.detailsTextField.text = """
 engine type: \(cars.element?.first?.engineType ?? "")
 engine size: \(cars.element?.first?.engineSize ?? 0.0)
 transmission: \(cars.element?.first?.transmissionType ?? "")
 makeID: \(cars.element?.first?.makeID ?? 0)
 year: \(cars.element?.first?.year ?? 0)
 makeName:\(cars.element?.first?.makeName ?? "")
 makeNiceName: \(cars.element?.first?.makeNiceID ?? "")
 makeNiceID: \(cars.element?.first?.makeNiceID ?? "")
 modelID: \(cars.element?.first?.modelID ?? "")
 modelName: \(cars.element?.first?.modelName ?? "")
 modelNiceName: \(cars.element?.first?.modelNiceName ?? "")
 modelNiceID: \(cars.element?.first?.modelNiceID ?? "")
 modelYearID: \(cars.element?.first?.year ?? 0)
 engineCylinder: \(cars.element?.first?.engineCylinder ?? 0)
 numberOfSeats: \(cars.element?.first?.numberOfSeats ?? 0)
 """
        }.disposed(by: disposeBag)
    }
    
}

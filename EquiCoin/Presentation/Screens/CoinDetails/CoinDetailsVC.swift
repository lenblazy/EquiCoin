//
//  CoinVC.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 30/04/2025.
//

import UIKit
import SwiftUI

class CoinDetailsVC: UIViewController {
    
    let labelPrice      = AppTitleLabel(textAlignment: .center, fontSize: 30, color: AppColors.light)
    let labelChange     = AppBodyLabel(textAlignment: .center, fontSize: 18, color: AppColors.grayLight)
    let statMarket      = StatView()
    let statVolume      = StatView()
    let statSymbol      = StatView()
    let statBtPrice     = StatView()
    let statAllTimeHigh = StatView()
    let statCirculation = StatView()
    let stackBtns       = UIStackView()
             
    var filters: [SelectableButton] = []
    
    private let viewModel: CoinDetailsVM
    private var period = "24h"
    private var coin: Coin!
    
    lazy var chartView: UIView = {
        return updateChartView(with: coin)
    }()
    
    init(coin: Coin) {
        self.coin = coin
        let datasource: CoinsDatasource = CoinsDatasourceImpl(apiManager: UrlSessionApiManager(), storage: DefaultsStorageManager())
        let repository: CoinsRepository = CoinsRepositoryImpl(datasource: datasource)
        let getCoinDetailsUseCase: GetCoinDetailsUseCase = GetCoinDetailsUseCaseImpl(repository: repository)
        
        self.viewModel = CoinDetailsVM(fetchCoinDetails: getCoinDetailsUseCase)
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBindings()
        let defaultPick = filters.first { $0.titleLabel?.text == period }
        defaultPick?.isSelected = true
        viewModel.fetchCoinDetails(coinID: coin.id, period: period)
    }
    
    
    private func configureUI() {
        view.backgroundColor    = AppColors.dark
        title                   = coin.name
        layoutViews()
    }
    
    
    private func layoutViews() {
        let paddingLarge: CGFloat = 16
        let paddingSmall: CGFloat = 8
        
        stackBtns.translatesAutoresizingMaskIntoConstraints = false
        stackBtns.axis = .horizontal
        stackBtns.spacing = paddingSmall
        stackBtns.distribution = .fillProportionally
        filters.append(contentsOf: [
//            SelectableButton(title: "1h"),
//            SelectableButton(title: "3h"),
            SelectableButton(title: "12h"),
            SelectableButton(title: "24h"),
            SelectableButton(title: "7d"),
            SelectableButton(title: "30d"),
            SelectableButton(title: "3m"),
            SelectableButton(title: "1y"),
//            SelectableButton(title: "3y"),
//            SelectableButton(title: "5y")
        ])
        
        filters.forEach {
            stackBtns.addArrangedSubview($0)
            $0.addTarget(self, action: #selector(filterResults), for: .touchUpInside)
        }
        
        view.addSubview(labelPrice)
        view.addSubview(labelChange)
        view.addSubview(chartView)
        view.addSubview(stackBtns)
        view.addSubview(statMarket)
        view.addSubview(statVolume)
        view.addSubview(statSymbol)
        view.addSubview(statBtPrice)
        view.addSubview(statAllTimeHigh)
        view.addSubview(statCirculation)
        
        NSLayoutConstraint.activate([
            labelPrice.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: paddingLarge),
            labelPrice.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelPrice.heightAnchor.constraint(equalToConstant: 34),
            
            labelChange.topAnchor.constraint(equalTo: labelPrice.bottomAnchor, constant: paddingSmall),
            labelChange.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelChange.heightAnchor.constraint(equalToConstant: 20),
                        
            chartView.topAnchor.constraint(equalTo: labelChange.bottomAnchor, constant: paddingLarge),
            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingLarge),
            chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingLarge),
            chartView.heightAnchor.constraint(equalToConstant: 200),
            
            stackBtns.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: paddingLarge),
            stackBtns.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingLarge),
            stackBtns.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingLarge),
            
            statMarket.topAnchor.constraint(equalTo: stackBtns.bottomAnchor, constant: paddingLarge),
            statMarket.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingLarge),
            statMarket.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingLarge),
            
            statVolume.topAnchor.constraint(equalTo: statMarket.bottomAnchor, constant: paddingLarge),
            statVolume.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingLarge),
            statVolume.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingLarge),
            
            statBtPrice.topAnchor.constraint(equalTo: statVolume.bottomAnchor, constant: paddingLarge),
            statBtPrice.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingLarge),
            statBtPrice.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingLarge),
            
            statSymbol.topAnchor.constraint(equalTo: statBtPrice.bottomAnchor, constant: paddingLarge),
            statSymbol.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingLarge),
            statSymbol.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingLarge),
            
            statAllTimeHigh.topAnchor.constraint(equalTo: statSymbol.bottomAnchor, constant: paddingLarge),
            statAllTimeHigh.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingLarge),
            statAllTimeHigh.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingLarge),
            
            statCirculation.topAnchor.constraint(equalTo: statAllTimeHigh.bottomAnchor, constant: paddingLarge),
            statCirculation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingLarge),
            statCirculation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingLarge)
            
        ])
        
        
    }
    
    @objc func filterResults(_ sender: SelectableButton) {
        filters.forEach { $0.isSelected = ($0 == sender) ? !$0.isSelected : false }
        if let time = sender.titleLabel?.text {
            period = time
            viewModel.fetchCoinDetails(coinID: coin.id, period: period)
        }
        
    }
    
    
    private func updateChartView(with coin: Coin) -> UIView {
        let chart = ChartUIView(sparkline: coin.sparkLine)
        let hostingController = UIHostingController(rootView: chart)
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.didMove(toParent: self)
        hostingController.view.backgroundColor = .clear
        
        return hostingController.view
    }
    
    
    private func populateViews(with coin: Coin) {
        chartView               = updateChartView(with: coin)
        let isNegativeRating    = coin.change.contains("-")
        labelPrice.text         = coin.price
        labelChange.text        = isNegativeRating ? coin.change : "+ \(coin.change)"
        labelChange.textColor   = isNegativeRating ? AppColors.error : AppColors.success
        statMarket.populate(title: "Market Cap", message: coin.marketCap)
        statVolume.populate(title: "Volume 24H", message: coin.volume)
        statBtPrice.populate(title: "Bitcoin Price", message: coin.bitCoinPrice)
        statSymbol.populate(title: "Symbol", message: coin.symbol)
        statAllTimeHigh.populate(title: "Circulating Supply", message: coin.circulatingSupply)
        statCirculation.populate(title: "All Time High", message: coin.allTimeHigh)
    }
    
    
    private func setupBindings() {
        viewModel.onCoinUpdated = { [weak self] coin in
            guard let strongSelf = self else { return }
            strongSelf.populateViews(with: coin)
        }
        
        viewModel.onError = { [weak self] errorMessage in
            guard let strongSelf = self else { return }
            strongSelf.presentAlert(message: errorMessage)
        }
        
        viewModel.isLoading = { [weak self] isLoading in
            guard let strongSelf = self else { return }
            isLoading ? strongSelf.showLoadingView() : strongSelf.dismissLoadingView()
        }
    }

}

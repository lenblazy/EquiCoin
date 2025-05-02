//
//  CoinVC.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 30/04/2025.
//

import UIKit
import SwiftUI

class CoinDetailsVC: UIViewController {
    
    let labelPrice  = AppTitleLabel(textAlignment: .center, fontSize: 30, color: AppColors.light)
    let labelChange = AppBodyLabel(textAlignment: .center, fontSize: 18, color: AppColors.grayLight)
    let statMarket  = StatView()
    let statVolume  = StatView()
    let statSymbol  = StatView()
    let statBtPrice = StatView()
    
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
        viewModel.fetchCoinDetails(coinID: coin.id, period: period)
    }
    
    
    private func configureUI() {
        view.backgroundColor    = AppColors.dark
        title                   = coin.name
        layoutViews()
    }
    
    
    private func layoutViews() {
        view.addSubview(labelPrice)
        view.addSubview(labelChange)
        view.addSubview(chartView)
        view.addSubview(statMarket)
        view.addSubview(statVolume)
        view.addSubview(statSymbol)
        view.addSubview(statBtPrice)
        
        let paddingLarge: CGFloat = 16
        let paddingSmall: CGFloat = 8
        
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
            
            statMarket.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: paddingLarge),
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
            statSymbol.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingLarge)
            
        ])
        
        
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

# :moneybag: EquiCoin

An iOS application that provides detailed information on the top 100 cryptocurrencies

## :clipboard: Description

This application built with **Swift**, integrating **UIKit** and **SwiftUI**. It 
displays the top 100 cryptocurrencies using the [CoinRanking API](https://developers.coinranking.com/api/documentation). 
This project demonstrates handling pagination, filtering, favoriting, and presenting detailed statistics and charts.

## 🧠 Objective

This project showcases the ability to:

- Design an iOS architecture using MVVM with clean architecture approach
- Integrate public APIs with pagination
- Combine UIKit and SwiftUI
- Implement dynamic filtering and data presentation
- Handle user interaction with gestures and persistent state

## 📱 Screens

### 1. **Top 100 Coins List**
- Displays coins in a paginated **UITableView**, 20 per page.
- Each coin includes:
  - Icon (loaded and cached using `URLSession`)
  - Name
  - Current Price (formatted and styled)
  - 24H Performance (% change)
- Features:
  - Sort/Filter: by **highest price** or **best 24H performance**
  - Swipe-to-favorite functionality using `UISwipeActionsConfiguration`

### 2. **Coin Details**
- Displays:
  - Coin name
  - Price
  - Historical performance chart (`Charts` framework via SwiftUI)
  - Performance filter controls (e.g., 1D, 30D, 1Y)
  - Additional stats: Market Cap, Volume, BTC price, etc.

### 3. **Favorites Screen**
- Displays favorited coins in a **UITableView**
- Supports:
  - Navigating to coin details
  - Swipe to unfavorite


## 🔧 Technical Specs

- **Architecture**: MVVM + Clean Architecture
- **UI Frameworks**: UIKit (TableView), SwiftUI (Charts)
- **Image Loading**: `URLSession` + image caching
- **Charting**: `Swift Charts` (iOS 16+)
- **Data Persistence**: `UserDefaults` for favorite tracking
- **Pagination**: Manual `fetchCoins(page: Int)` when scrolling to bottom
- **Async/Await**: Used for all network calls


## 🧪 Features

| Feature                         | Status     |
|-------------------------------|------------|
| Top 100 Coins List             | ✅ Done     |
| Paginated API loading          | ✅ Done     |
| Sorting/Filtering              | ✅ Done     |
| Swipe-to-favorite              | ✅ Done     |
| Coin detail screen             | ✅ Done     |
| Sparkline chart (SwiftUI)      | ✅ Done     |
| Favorites list screen          | ✅ Done     |
| Swipe to unfavorite            | ✅ Done     |

## 📦 Dependencies

All features implemented **natively** without external libraries (unless specified):

- `Swift Charts` (for line chart visualization)
- `UIKit` for structure and layout
- `SwiftUI` for modular components


## 🛠 How to Run

1. Clone the repository
   ```bash
   git clone https://github.com:lenblazy/EquiCoin.git
   cd EquiCoin
   ```
3. Open `EquiCoin.xcodeproj`
4. Ensure you're running iOS 16+ (for Swift Charts support)
5. Build and run on a simulator or device

---

## 🔐 API Key

The app expects a valid CoinRanking API key.

1. Visit: [CoinRanking Docs](https://developers.coinranking.com/api/documentation)
2. Replace the placeholder in `NetworkManager.swift`:
3. Navigate through folders EquiCoin>Core>Network and open `EndpointProvider.swift`

```swift
private let apiKey = "YOUR_API_KEY"
```
## :test_tube: Running The Tests

- The project can be tested using the built-in framework XCTest.
- Test files are available in the EquiCoinTests folder.

## Assumptions/ Decisions

- The project was built in dark mode. This was through inspirations picked from [dribble](https://dribbble.com/search/cryptocurrency-app)

## Challenges Faced

Coin API returned images in different formats, some were .svg files and others .png files. 
While the .png files worked correctly on UIImageView. The .svg files were failing because of a UIImageView Limitation. 
If you **try loading an SVG into a UIImageView **, it will **fail silently** or show nothing — because UIImage can’t interpret SVG format.
I had to use a third party library [SVGKit](https://github.com/SVGKit/SVGKit) to sort this issue. 


   

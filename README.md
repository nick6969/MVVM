# 關於

這是一個 MVVM 的展示專案

ViewModel 使用 POP & OOP 建立

方便使用，並且減少大量重複的 Code


--

# 架構

### Model
Just Model

--------------

### ViewModel
#### 持有 Models
    var models: [Model]

#### 有自己的狀態
    var status: ViewModelStatus

#### 負責取得資料(Web Api / Locale DB)
    func loadData()
    func loadDataMode()

#### 負責通知 ViewController Loading 狀態
    var loadingDelegate: ViewModelLoadingDelegate?
    var loadingStatusDelegate: ViewModelLoadingStatusDelegate?

#### 提供 Method 讓 ViewController 取用 Model
    var datasCount: Int
    func model(at index: Int) -> Model?
    func isLastData(index: Int) -> Bool
    func isLoadMore(index: Int) -> Bool

#### 提供 Method 讓 ViewController 呼叫做事
    func refreshData()
    func nextStatus()

--------------

### ViewController
#### 持有 ViewModel
    var viewModel: BaseViewModel

#### conform ViewModel 的 Delegate
extension ViewController: ViewModelLoadingDelegate

    func loadingDone()
    func loadingFail(_ error: Error?)

extension ViewController: ViewModelLoadingStatusDelegate

    func showEmptyView(with: Error?)
    func removeEmptyView()
    func showLoading(_ bool: Bool)

#### 請 ViewModel 做事
    viewModel.nextStatus()
    viewModel.refreshData()

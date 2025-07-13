# Coin Detector

用MATLAB App Designer製作的圖像辨識應用程式，可以選擇幣值並計算圖片中有多少錢（硬幣）
<img width="735" height="auto" src="https://github.com/user-attachments/assets/a8fdec96-9474-4335-b391-8648a2b2e7ac" />

> 目錄  
> [1. 檔案結構](#1-檔案結構)  
> [2. 介面說明](#2-介面說明)  
> [3. 主要功能](#3-主要功能)  
> [4. 未來延伸方向](#4-未來延伸方向)  
> [5. 參考資料](#5-參考資料)  
> [6. 版本紀錄](#6-版本紀錄)  
> [7. 執行畫面](#7-執行畫面)  

---

## 1. 檔案結構

```bash
Coin_Dector/
├── Test images/     # 測試用影像
│   ├── TWD.jpg      # 臺幣
│   ├── coin.png     # 美元
│   └── eight.tif    # 美元
├── Test script/                     # 先置腳本與函式
│   ├── AddCoinToPlotAndCount.m      # 計算並在圖片上標示結果
│   ├── Coin_detector.m              # 完整的硬幣偵測腳本
│   ├── MakeCircleMatchingFilter.m   # 建立一定大小的matching filter
│   └── OtsuThreshold.m              # 執行Otsu Threshold
└── Coin_Detector_App.mlapp          # 轉換成App後的形式

```
> [點此下載完整專案檔案](https://drive.google.com/drive/folders/1-D5UgijT_5InEhXBYiiSqBUUM_nXsmHW?usp=sharing)

---

## 2. 介面說明

<img width="735" height="auto" src="https://github.com/user-attachments/assets/e6c27ed8-9959-4f0f-bb96-c24b5ebc1de6" />

|區域|功能描述|
|-----|---------------------------------------|
|繪圖區|繪製原始影像及處理後的影像|
|幣值選擇區|選擇要偵測的幣值種類|
|切換影像種類|切換要顯示的（處理後的）影像|
|載入按鈕|載入要偵測的影像|
|結果區|顯示偵測到的硬幣價值|

---

## 3. 主要功能

|類別|功能描述|
|-----|---------------------------------------|
|影像讀取|可從電腦中讀取要偵測的影像|
|影像切換|有Otsu threshold, eroded, dilated, result四種可展示影像|
|幣值切換|有臺幣、美元兩種可以選擇|
|總額計算|自動計算偵測到的硬幣總價值|
> 備註：經過調整參數後，這是目前的平均最佳表現，仍然有1~2個硬幣會被判別錯誤。

---

## 4. 未來延伸方向

|延伸項目|說明|
|:----------:|---------------------------------------------|
|提升準確度|改變影像處理或分類的方法，在保留泛用度的同時提升準確度|
|更多幣值|新增日幣等不同種幣值，進一步增加泛用度|
|自動偵測硬幣直徑|自動根據硬幣的相對大小決定濾波器的直徑，解決拍攝距離造成的誤差|

---

## 5. 參考資料

[Morphological Operations - MATLAB & Simulink](https://www.mathworks.com/help/images/morphological-filtering.html)  

[【影像處理】形態學Morphology](https://jason-chen-1992.weebly.com/home/-morphology)

---

## 6. 版本紀錄

### Version 0
- 撰寫輔助函式
- 使用腳本偵測固定的內建影像

### Version 1
- 改用App designer製作
- 設計介面
- 新增幣值選擇功能（直徑固定）
- 新增讀取影像功能
- 新增影像比對功能

---

## 7. 執行畫面

### ▸ 初始畫面
<img width="735" height="auto" src="https://github.com/user-attachments/assets/65ac4928-24e5-4421-871e-f31363df1e36" />

### ▸ 臺幣
<img width="735" height="auto" src="https://github.com/user-attachments/assets/e63f5364-5c12-48f5-81f5-8faf11d503d4" />

### ▸ 美元-I
<img width="735" height="auto" src="https://github.com/user-attachments/assets/edbe22c0-860b-42a9-8fa0-87f49640660c" />

### ▸ 美元-II
<img width="735" height="auto" src="https://github.com/user-attachments/assets/50397158-1edf-44dc-9b97-7f10c062d5ef" />

### ▸ 每階段的影像
<img width="735" height="auto" src="https://github.com/user-attachments/assets/e0daab80-75a5-4ada-9cb1-f3035e524da4" />








